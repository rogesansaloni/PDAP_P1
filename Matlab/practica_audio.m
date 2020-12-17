%Definicion variables
path = '../Ficheros/Categorias';
methodLM = 'knn';
knn_K = 10;
percentOfDataSet = 0.05;
%Paso 1: obtenemos el audiodatastore
ads = audioDatastore(path,'IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
%Dividimos los datos en el procentaje especificado
[ads1,ads2] = splitEachLabel(ads,percentOfDataSet);

[features,labels] = extractFeaturesLabels(ads1);
okPositions = cell(1,4);
koPositions = cell(1,4);
accuracy = zeros(4,1);
nTramas = size(features{1},1) / size(labels{1},1);
for k = 1:4
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


function [features,labels] = extractFeaturesLabels(ads)
    %Esta función se encarga de dividir la información del ads en 4 partes,
    %obteniendo los cell arrays y los vectores de categories de cada parte, y
    %creando el array features y labels con estos datos, respectivamente.
    [ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);
    adsSplit = {ads1, ads2, ads3, ads4};
    features = cell(1,4);
    labels = cell(1,4);
    aFE = audioFE();
    for i = 1:4
        ads = adsSplit{i};
        adsTall = tall(ads);
        featuresTall = cellfun(@(x)extract(aFE,x),adsTall, "UniformOutput", false);
        features{i} = cell2mat(gather(featuresTall));
        
        labels{i} = ads.Labels;
    end
end

function aFE = audioFE ()
    %Usada para definir los atributos que analizaremos de los audios
    fs = 44100; 
    aFE = audioFeatureExtractor(...
    "SampleRate",fs, ...
    "Window",hamming(round(0.6*fs),"periodic"), ...
    "OverlapLength",round(0.5*fs), ...
    "melSpectrum",true,...
    "mfcc",true, ...
    "pitch",true, ...
    "spectralCentroid",true);
end