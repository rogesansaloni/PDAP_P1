function ypred = GMM(learnDB, learnGT, testDB, k)
%Esta función aplica el clasificador GMM.
%Para cada categoria se crea un modelo gmmModel
categories = unique(learnGT);
numCategories = size(categories);
gmmModel = cell(1, length(numCategories));
gmmPDF = zeros((size(testDB,1)), length(numCategories));
ypred = [];
%entrenamos un gmmModel para cada categoría
for i = 1: numCategories
    name_category = categories(i);
    positions = find(learnGT == name_category);
    data_category = [];
    for n = 1:size(positions)
        data_category = [data_category;learnDB(positions(n))];
    end
    gmmModel{i} = fitgmdist(data_category,k,'RegularizationValue',0.1,'CovarianceType','diagonal');
end
%Aplicamos cada gmmModel a cada fila de testDB, y obtenemos la máxima
%probabilidad para asignarle la categoria
for n = 1:size(testDB)
    for i = 1:length(gmmModel)
        gmmPDF(n,i) = pdf(gmmModel{i}, testDB(n,:));
    end
    valor_maximo = max(gmmPDF(n,:));
    indice_categoria = find(gmmPDF(n,:)==valor_maximo);
    categoria = categories(indice_categoria,1);
    ypred = [ypred; categoria];
end
%disp('GMM-> maxima probabilidad ', ypred);
end

