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
aFE = audioFE ('../Ficheros/Categorias/car/a062_100_110.wav');


%EXTRACCION DE ATRIBUTOS DE CARPETAS ENTERAS:
featuresTall = cellfun(@(x)extract(aFE,x),adsTall1, "UniformOutput", false);
features = gather(featuresTall);
%Longitud N, array de un campo solo con las etiquetas de los N ficheros
labels = ads1.Labels;

%features es un cell array de N posiciones (numero de ficheros de la bbdd ads)
%en cada celda tiene una matriz de atributos
%La dimension de este array es de MxR
%M filas-> numero de ventanas de la señal que caben en el fichero
%R columnas -> numero de atributos configurados en audioFeatureExtractor
%y = GMM(adsTall, categories, 1);


%-------------------------------------------------------------------

%1- SEGMENTACION DE LA BBDD:
%features y labels contienen los arrays y vectores de categorias de las 4 particiones
%de datos
[features4,labels4] = extractFeaturesLabels(ads1);

%Para llamar a los at. de audio del 4º audio de la primera particion
%hacemos features{1}{4} y labels {1}{4}

for i = 1:4
   %2- Calcular dos matrices learn y test que contengan
        %Atributos de todos los audios (learnDB, testDB)
        %vectores categoricos (learnGT, testGT) MEDIANTE CONCATENACION y
        %REPL. ETIQUETAS (es decir, todas las labels, no eliminar las
        %repetidas)
    
       %INTENTO: (aun no funciona)
        [learn, test] = splitEachLabel(ads1,0.5);
        
        learnTall1 = tall(learn);
        
        featuresTall = cellfun(@(x)extract(aFE,x),learnTall1, "UniformOutput", false);
        features = gather(featuresTall);
        %Longitud N, array de un campo solo con las etiquetas de los N ficheros
        labels = learn.Labels;
        disp (length(labels));
    %3- entrenamiento de un clasificador (ELEGIR SOLO UNO, IR CAMBIANDO) con learnDB y learnGT
    
    %4-Clasificacion de testDB con el mismo método de clasificacion
        %Cálculo de la Accuracy comparando las etiquetas reales (testGT) con las
        %obtenidas 
        
        
    %5 - Mostrar info
        
        
    
end