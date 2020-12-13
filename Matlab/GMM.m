function ypred = GMM(X, categories, k)
%Esta función aplica el clasificador GMM.
%Para cada categoria se crea un modelo gmmModel
gmmModel = cell(1, length(categories));
gmmPDF = cell(1, length(categories));
x = 0:.1:1;
    for i = 1: length(categories)
        gmmModel{i} = fitgmdist(X,k);
        gmmPDF{i} = pdf(gmmModel, x);
    end
    ypred = max (gmmPDF);
    disp('GMM-> maxima probabilidad ', ypred);
end

