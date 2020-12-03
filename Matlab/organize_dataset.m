%leemos el archivo meta.txt y error.txt
meta = readtable('..\Ficheros\meta.txt','Delimiter','\t','ReadVariableNames',false);
errors = readtable('..\Ficheros\error.txt','Delimiter','\t','ReadVariableNames',false);
%obtenemos todas las categorías
categories = unique(meta{:,2});
mkdir ../Ficheros Categorias
for i = 1:length(categories)
    mkdir ('../Ficheros/Categorias',categories{i, 1});
end
for i = 1:length(meta)
    audio_name = meta(i).Var1;
    dir audio_name.m
    if audio_name = 
end
dir ../Ficheros/Audios/audios1
%for i = 1:
%filename = cell2mat(T{r,1});
%category = cell2mat(T{r,2});
