%Leemos el archivo meta.txt y error.txt
meta = readtable('../Ficheros/meta.txt','Delimiter','\t','ReadVariableNames',false);
meta(:,2).Var2 = replace(meta(:,2).Var2,"cafe/restaurant","cafe-restaurant");
errors = readtable('../Ficheros/error.txt','Delimiter','\t','ReadVariableNames',false);
%Obtenemos todas las categorias
categories = unique(meta{:,2});
mkdir '../Ficheros/Categorias'
for i = 1:length(categories)
    mkdir ('../Ficheros/Categorias',categories{i, 1});
end
[meta_rows, meta_columns] = size(meta);

for i = 1:meta_rows
    audio_name =  cell2mat(meta{i,1});
    if ~(searchForErrors(audio_name, errors))
        new_audio_name = strrep(audio_name,"audio/","");
        old_path = strcat("../Ficheros/Audios/",new_audio_name);
        if isfile(old_path)
            audio_category = cell2mat(meta{i,2});
            [x,Fs] = audioread(old_path);
            x = 0.5*sum(x,2);
            new_path = strcat("../Ficheros/Categorias/",audio_category,"/",new_audio_name);
            audiowrite(new_path,x,Fs);
        end
    end
        
end

