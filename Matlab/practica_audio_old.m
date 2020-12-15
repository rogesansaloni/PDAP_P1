%Paso 1
ads = audioDatastore('../Ficheros/Categorias','IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
adsTall = tall(ads);
%Difinimos en cuantas n partes dividiremos la informacion
n=20;
p=1/n;
[ads1, ads2, ads3, ads4, ads5, ads6, ads7, ads8, ads9, ads10] = splitEachLabel(ads,p,p,p,p,p,p,p,p,p);
adsSplit = {ads1, ads2, ads3, ads4, ads5, ads6, ads7, ads8, ads9, ads10};
adsTall1 = tall(ads1);
%[features, labels] = extractFeaturesLabels(adsSplit{1,1});
meta = readtable('../Ficheros/meta.txt','Delimiter','\t','ReadVariableNames',false);
categories = unique(meta{:,2});

%EXTRACCION DE ATRIBUTOS DE CADA AUDIO DE CARPETAS ENTERAS:
%featuresTall = cellfun(@(x)extract(aFE,x),adsTall1, "UniformOutput", false);
%featuresSA = gather(featuresTall);
%Longitud N, array de un campo solo con las etiquetas de los N ficheros
%labelsSA = ads1.Labels;

%features es un cell array de N posiciones (numero de ficheros de la bbdd ads)
%en cada celda tiene una matriz de atributos
%La dimension de este array es de MxR
%M filas-> numero de ventanas de la señal que caben en el fichero (numero
%de muestras, es decir, como de larga es la señal)

%R columnas -> numero de atributos configurados en audioFeatureExtractor

%y = GMM(adsTall, categories, 1);


%-------------------------------------------------------------------

%1- SEGMENTACION DE LA BBDD ENTERA:
%features y labels contienen los arrays y vectores de categorias de las 4 particiones
%de datos
[features4,labels4,adsSplit4] = extractFeaturesLabels(ads1);
aFE = audioFE();
%Para llamar a los at. de audio del 4º audio de la primera particion
%hacemos features{1}{4} y labels {1}{4}
okPositions = cell(1,4);
koPositions = cell(1,4);
%for k = 1:4
   %2- Calcular dos matrices learn y test que contengan
        %Atributos de todas las tramas de todos los audios (learnDB, testDB)
        %vectores categoricos (learnGT, testGT) MEDIANTE CONCATENACION y
        %REPL. ETIQUETAS (es decir, todas las labels de TODAS LAS TRAMAS, no eliminar las
        %repetidas)
        
        %Divido la particion 1 en dos, 75% (learn) y 25% (test)
        [learn, test] = splitEachLabel(adsSplit4{1}, 0.75);
        %----------------------------------------LEARN----------------------------------------------%
        learnTall = tall(learn);        
        %Obtenemos learnFutures
        learnfeaturesTall = cellfun(@(x)extract(aFE,x),learnTall, "UniformOutput", false);
        learnFeatures = gather(learnfeaturesTall);
        [numTramasLearn, numFeaturesLearn, numCanalesLearn] = size (learnFeatures{1});
        
        %LEARNDB tiene 41916 filas (45 files en bbdd learn * 998 tramas por file) y 703 columnas (numero de atributos de aFE)
        %LEARNGT tiene por tanto 41916 filas y 1 columna, ya que guarda
        %todas las labels de todas las tramas de learnDB, aunque esten
        %repetidas
        learnDB = cell2mat(learnFeatures);
        learnLabels = learn.Labels;
        numLearnSignals = numel(learnLabels);
        learnLabels = repmat(learnLabels,1,numTramasLearn);
        learnGT = reshape(learnLabels,numLearnSignals*numTramasLearn,1);
        %----------------------------------------TEST----------------------------------------------%
        testTall = tall(test);
        testfeaturesTall = cellfun(@(x)extract(aFE,x),testTall, "UniformOutput", false);
        testFeatures = gather(testfeaturesTall);
        [numTramasTest, numFeaturesTest, numCanalesTest] = size (testFeatures{1});
        testDB = cell2mat(testFeatures);
        
        testLabels = test.Labels;
        numTestSignals = numel(testLabels);
        testLabels = repmat(testLabels,1,numTramasTest);
        testGT = reshape(testLabels,numTestSignals*numTramasTest,1);
    %3- entrenamiento de un clasificador (ELEGIR SOLO UNO, IR CAMBIANDO) con learnDB y learnGT
        %testPred = KNN(learnDB,learnGT,testDB);
    %4-Clasificacion de testDB con el mismo método de clasificacion
        %Cálculo de la Accuracy comparando las etiquetas reales (testGT) con las
        %obtenidas 
%         okPositions{i} = find(testPred==testGT);
%         koPositions{i} = find(testPred~=testGT);
%         accuary = (length(okPositions)/(length(okPositions)+length(koPositions)))*100
    %5 - Mostrar info
       
%end