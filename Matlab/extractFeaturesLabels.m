function [features,labels] = extractFeaturesLabels(ads)
    %Esta función se encarga de dividir la información del ads en 4 partes,
    %obteniendo los cell arrays y los vectores de categories de cada parte, y
    %creando el array features y labels con estos datos, respectivamente.
    [ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);
    adsSplit = {ads1, ads2, ads3, ads4};
    features = cell(1,4);
    labels = cell(1,4);
    for i = 1:4
        adsTall = tall(adsSplit{i});
        features{i} = gather(adsTall); 
        labels{i} = adsSplit{i}.Labels;
    end
end

