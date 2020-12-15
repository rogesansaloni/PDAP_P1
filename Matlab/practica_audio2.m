%Paso 1
ads = audioDatastore('../Ficheros/Categorias','IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
adsTall = tall(ads);
%Difinimos en cuantas n partes dividiremos la informacion
n=20;
p=1/n;
[ads1, ads2] = splitEachLabel(ads,p);
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
[features,labels,adsSplit] = extractFeaturesLabels(ads1);
[features2,labels2,adsSplit2] = extractFeaturesLabels2(ads1);
aFE = audioFE();
%Para llamar a los at. de audio del 4º audio de la primera particion
%hacemos features{1}{4} y labels {1}{4}
okPositions = cell(1,4);
koPositions = cell(1,4);
for k = 1:4
   %2- Calcular dos matrices learn y test que contengan
        %Atributos de todas las tramas de todos los audios (learnDB, testDB)
        %vectores categoricos (learnGT, testGT) MEDIANTE CONCATENACION y
        %REPL. ETIQUETAS (es decir, todas las labels de TODAS LAS TRAMAS, no eliminar las
        %repetidas)
        
        %----------------------------------------TEST----------------------------------------------%
        testDB2 = cell2mat(features2{k});
        testGT2 = labels2{k};
        
        %----------------------------------------LEARN----------------------------------------------%
        learnDB = [];
        learnGT = [];
        for i = 1:4
            if i ~= k
                learnDB = [learnDB; features{i}];
                learnGT = [learnGT; labels{i}];
            end
        end
        
    %3- entrenamiento de un clasificador (ELEGIR SOLO UNO, IR CAMBIANDO) con learnDB y learnGT
        %testPred = KNN(learnDB,learnGT,testDB);
    %4-Clasificacion de testDB con el mismo método de clasificacion
        %Cálculo de la Accuracy comparando las etiquetas reales (testGT) con las
        %obtenidas 
%         okPositions{i} = find(testPred==testGT);
%         koPositions{i} = find(testPred~=testGT);
%         accuary = (length(okPositions)/(length(okPositions)+length(koPositions)))*100
    %5 - Mostrar info
       
end