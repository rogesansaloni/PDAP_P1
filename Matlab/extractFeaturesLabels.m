function [features,labels] = extractFeaturesLabels(ads)
%Esta función se encarga de dividir la información del ads en 4 partes,
%obteniendo los cell arrays y los vectores de categories de cada parte, y
%creando el array features y labels con estos datos, respectivamente.
[ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);
adsSplit = {ads1, ads2, ads3, ads4};
features = cell(1,4);
labels = cell(1,4);
for i = 1:4
    %Obtenemos el tall de cada una de las 4 particiones, y se lo asignamos
    %a la posicion correspondiente del array features
    adsTall = tall(adsSplit{1,i});
    features{i} = gather(adsTall);
    %Obtenemos los labels de cada particion de los datos
    labels{i} = adsSplit{1,i}.Labels;
end
end

