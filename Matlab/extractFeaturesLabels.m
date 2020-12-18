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
%         lengthFeatures = size(features{i},1);
%         numLabels = numel(labelsAds);
%         labelsAds = repmat(labelsAds,1,lengthFeatures);
%         labels{i} = reshape(labelsAds,numLabels*lengthFeatures,1);
    end
end