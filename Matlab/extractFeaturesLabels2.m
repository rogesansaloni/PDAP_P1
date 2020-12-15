function [features,labels, adsSplit] = extractFeaturesLabels2(ads)
    %Esta función se encarga de dividir la información del ads en 4 partes,
    %obteniendo los cell arrays y los vectores de categories de cada parte, y
    %creando el array features y labels con estos datos, respectivamente.
    [ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);
    adsSplit = {ads1, ads2, ads3, ads4};
    features = cell(1,4);
    labels = cell(1,4);
    aFE = audioFE();
    for i = 1:4
        ads = adsSplit{1};
        adsTall = tall(ads);
        featuresTall = cellfun(@(x)extract(aFE,x),adsTall, "UniformOutput", false);
        features{i} = gather(featuresTall);
        
        labelsAds = adsSplit{i}.Labels;
        lengthFeatures = length(features{i}{1});
        numSignals = numel(labelsAds);
        labelsAds = repmat(labelsAds,1,lengthFeatures);
        labels{i} = reshape(labelsAds,numSignals*lengthFeatures,1);
    end
end