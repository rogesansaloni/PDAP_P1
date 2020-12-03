%leemos el archivo meta.txt y error.txt
meta = readtable('..\Ficheros\meta.txt','Delimiter','\t','ReadVariableNames',false);
error = readtable('..\Ficheros\error.txt','Delimiter','\t','ReadVariableNames',false);
%obtenemos todas las categorías
categories = unique(meta{:,2});
for 
filename = cell2mat(T{r,1});
category = cell2mat(T{r,2});
