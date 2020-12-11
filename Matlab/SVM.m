function ypred = SVM(X,Y, Xnew)
%Esta funci�n aplica el clasificador SVM.
%
t = templateSVM('KernelFunction','rbf','Standardize',true);
svmModel = fitcecoc(X, Y,'Learner',t);
ypred = predict(svmModel, Xnew);
end

