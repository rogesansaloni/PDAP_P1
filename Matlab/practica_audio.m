%Paso 1
ads = audioDatastore('../Ficheros/Categorias','IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
adsTall = tall(ads);
[ads1, ads2, ads3, ads4, ads5, ads6, ads7, ads8, ads9, ads10] = splitEachLabel(ads,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1);

