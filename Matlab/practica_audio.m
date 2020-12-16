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
accuracy = zeros(4,1);
nTramas = size(features{1},1) / size(labels{1},1);
for k = 1:4
   %2- Calcular dos matrices learn y test que contengan
        %Atributos de todas las tramas de todos los audios (learnDB, testDB)
        %vectores categoricos (learnGT, testGT) MEDIANTE CONCATENACION y
        %REPL. ETIQUETAS (es decir, todas las labels de TODAS LAS TRAMAS, no eliminar las
        %repetidas)
        %----------------------------------------TEST----------------------------------------------%
        testDB = [];
        testGT = [];
        testDB = features{k};
        nAudios = size(labels{k},1);
        for n = 1: nAudios
            input2 = labels{k}(n,:);
            inputArray2 = [];
            for n2 = 1:nTramas
                inputArray2 = [inputArray2 input2];
            end
            testGT = [testGT inputArray2];
        end
        testGT = testGT.';
        %----------------------------------------LEARN----------------------------------------------% 
        learnDB = [];
        learnGT = [];
        for i = 1:4
            if i ~= k
                learnDB = [learnDB;features{i}];
                nAudios = size(labels{i},1);
                for n = 1: nAudios
                    input = labels{i}(n,:);
                    inputArray = [];
                    for n2 = 1:nTramas
                        inputArray = [inputArray input];
                    end
                    learnGT = [learnGT inputArray]; 
                end
            end 
        end
        learnGT = learnGT.';
    %3- entrenamiento de un clasificador (ELEGIR SOLO UNO, IR CAMBIANDO) con learnDB y learnGT
        testPred = KNN(learnDB,learnGT,testDB);
    %4-Clasificacion de testDB con el mismo método de clasificacion
        %Cálculo de la Accuracy comparando las etiquetas reales (testGT) con las
        %obtenidas 
        okPositions{k} = find(testPred==testGT);
        koPositions{k} = find(testPred~=testGT);
        accuracy_k = (length(okPositions{k})/(length(okPositions{k})+length(koPositions{k})))*100;
        accuracy(k) = accuracy_k;
    %5 - Mostrar info
end
accuracy_mean = mean(accuracy);