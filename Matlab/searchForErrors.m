function error = searchForErrors(filename,errors)
%Esta funci�n comprueba si el archivo de audio se encuentra dentro de los
%archivos que tienen alg�n error
[errors_rows, errors_columns] = size(errors);
error = false;
for i = 1:errors_rows
    name_audio = errors(i,1).Var1;
    if strcmp(name_audio,filename)
        error = true;
        return
    end
end
end

