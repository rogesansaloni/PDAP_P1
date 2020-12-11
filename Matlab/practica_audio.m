%AudioDataStore permite manipular grandes bbdd sin cargarlas de forma
%explicita en la memoria
ads = audioDatastore('../PDAP_P1/Ficheros/Categorias/car', 'IncludeSubfolders',true,'FileExtensions','.wav', 'LabelSource','foldernames');
%Esta comanda lee Categorias/car y crea un almacenaje de audio de todos los
%.wav contenidos en subcarpetas de esta carpeta, y asociara el nombre de
%las subcarpetas a la categoria asociada del audio contenido

%Las propiedades de ads se leen con x ejemplo, ads.Labels que devuelve N
%valores con el nombre de la clase de los N ficheros analizados

%ads.Files devuelve el nombre de los N ficheros

%La funcion tall crea un array con los N audios, pero no los evaluará hasta
%que sea necesario.
adsTall = tall(ads);

%La funcion splitEachLabel permite dividir en subcolecciones. Recomendable
%hacer pruebas cogiendo solo 5l 5% o 10% de los datos para ir mas rapido,
%dividiendo con esta funcion
[ads1, ads2, ads3, ads4] = splitEachLabel(ads,0.25,0.25,0.25);



