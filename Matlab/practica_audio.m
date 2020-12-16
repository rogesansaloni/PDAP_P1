%Paso 1
ads = audioDatastore('../Ficheros/Categorias','IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
%Difinimos en cuantas n partes dividiremos la informacion
n=20;
p=1/n;
[ads1, ads2] = splitEachLabel(ads,p);

%1- SEGMENTACION DE LA BBDD ENTERA:
%features y labels contienen los arrays de atributos y vectores de categorias de las 4 particiones
%de datos respectivamente
[features,labels] = extractFeaturesLabels(ads1);
okPositions = cell(1,4);
koPositions = cell(1,4);
for k = 1:4
   %2- Calcular dos matrices learn y test que contengan
        %Atributos de todas las tramas de todos los audios (learnDB, testDB)
        %vectores categoricos (learnGT, testGT) MEDIANTE CONCATENACION y
        %REPL. ETIQUETAS (es decir, todas las labels de TODAS LAS TRAMAS, no eliminar las
        %repetidas)
        %----------------------------------------TEST----------------------------------------------%
        testDB = cell2mat(features{k});
%         testGT = labels{k};
%         %----------------------------------------LEARN----------------------------------------------%
%         learnDB = [];
%         learnGT = [];
%         for i = 1:4
%             lengthFeature = size(features{i},1);
%             if i ~= k
%                 for n = 1:lengthFeature
%                     learnDB = [learnDB; features{i}(n,:)];
%                     learnGT = [learnGT; labels{i}(n,:)];
%                 end
%             end
%         end
       
    %3- entrenamiento de un clasificador (ELEGIR SOLO UNO, IR CAMBIANDO) con learnDB y learnGT
        %testPred = KNN(learnDB,learnGT,testDB);
    %4-Clasificacion de testDB con el mismo método de clasificacion
        %Cálculo de la Accuracy comparando las etiquetas reales (testGT) con las
        %obtenidas 
%         okPositions{i} = find(testPred==testGT);
%         koPositions{i} = find(testPred~=testGT);
%         accuracy = (length(okPositions)/(length(okPositions)+length(koPositions)))*100
    %5 - Mostrar info
       
end