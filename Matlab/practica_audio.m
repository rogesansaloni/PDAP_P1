%Paso 1
ads = audioDatastore('../Ficheros/Categorias','IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
adsTall = tall(ads);
%Difinimos en cuantas n partes dividiremos la informacion
n=10;
p=1/n;
[ads1, ads2, ads3, ads4, ads5, ads6, ads7, ads8, ads9, ads10] = splitEachLabel(ads,p,p,p,p,p,p,p,p,p);
adsSplit = {ads1, ads2, ads3, ads4, ads5, ads6, ads7, ads8, ads9, ads10};
%[features, labels] = extractFeaturesLabels(adsSplit{1,1});
meta = readtable('../Ficheros/meta.txt','Delimiter','\t','ReadVariableNames',false);
categories = unique(meta{:,2});
audioFeatureExtractor ('../Ficheros/Categorias/car/a062_100_110.wav');
%y = GMM(ads1, categories, 2);