%Definicion variables
path = '../Ficheros/Categorias';
methodLM = 'knn';
knn_K = 10;
gmm_N = 2;
percentOfDataSet = 0.05;
%Paso 1: obtenemos el audiodatastore
ads = audioDatastore(path,'IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
%Dividimos los datos en el procentaje especificado
[ads1,ads2] = splitEachLabel(ads,percentOfDataSet);

%1- SEGMENTACION DE LA BBDD ENTERA:
%features y labels contienen los arrays de atributos y vectores de categorias de las 4 particiones
%de datos respectivamente
%[features,labels] = extractFeaturesLabels(ads1);
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
    %3- Entrenamiento con un clasificador
    switch methodLM
       case 'knn'
          testPred = KNN(learnDB,learnGT,testDB,knn_K);
          accuracy(k) = getAccuracy(testPred,testGT);
       case 'cart'
          testPred = CART(learnDB,learnGT,testDB);
          accuracy(k) = getAccuracy(testPred,testGT);
       case 'svm'
          testPred = SVM(learnDB,learnGT,testDB);
          accuracy(k) = getAccuracy(testPred,testGT);
       case 'gmm'
          testPred = GMM(learnDB,learnGT,testDB,gmm_N);
          accuracy(k) = getAccuracy(testPred,testGT);
       otherwise
          disp('Por favor, asigna uno de los métodos disponibles a la variable methodLM: knn, cart, svm o gmm.');
    end
end
accuracy_mean = mean(accuracy);