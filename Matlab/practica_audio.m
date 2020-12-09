ads = audioDatastore('../PDAP_P1/Ficheros/Categorias/car', 'IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
[ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);
adsTall = tall(ads);
adsTall1 = tall(ads1);