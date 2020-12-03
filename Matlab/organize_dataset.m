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
    if ~(searchForErrors(audio_name, errors))
        replace(audio_name,"audio/","");
        audio_name
    end
        
end
%for i = 1:
%filename = cell2mat(T{r,1});
%category = cell2mat(T{r,2});
