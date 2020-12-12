function ypred = SVM(X,Y, Xnew)
%Esta función aplica el clasificador GMM.
%Probamos con k = 2
k=2;
gmmModel = fitgmdist(X,k);
ypred = pdf(gmmModel, Xnew);
end

