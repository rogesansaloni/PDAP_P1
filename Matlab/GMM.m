function ypred = GMM(learnDB, learnGT, testDB)
%Esta función aplica el clasificador GMM.
%Para cada categoria se crea un modelo gmmModel
categories = unique(learnGT);
numCategories = size(categories);
k = 2;
gmmModel = cell(1, length(numCategories));
gmmPDF = cell(1, length(numCategories));
for i = 1: numCategories
    name_category = categories(i);
    positions = find(learnGT == name_category);
    data_category = [];
    for n = 1:size(positions)
        data_category = [data_category;learnDB(positions(n))];
    end
    gmmModel{i} = fitgmdist(data_category,k);
    gmmPDF{i} = pdf(gmmModel{i}, testDB);
end
ypred = max(gmmPDF);
%disp('GMM-> maxima probabilidad ', ypred);
end

