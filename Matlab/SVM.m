function ypred = SVM(learnDB, learnGT, testDB)
%Esta función aplica el clasificador SVM.
t = templateSVM('KernelFunction','rbf','Standardize',true);
svmModel = fitcecoc(learnDB, learnGT,'Learner',t);
ypred = predict(svmModel, testDB);
end

