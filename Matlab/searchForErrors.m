function error = searchForErrors(filename,errors)
%Esta función comprueba si el archivo de audio se encuentra dentro de los
%archivos que tienen algún error
error = false;
for i = 1:length(erros)
    name_audio = erros(i).Var1;
    if filename == name_audio
        error = true;
        return
    end
end
end

