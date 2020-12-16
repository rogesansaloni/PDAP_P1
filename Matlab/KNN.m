function ypred = KNN(learnDB, learnGT, testDB)
%Esta funci�n aplica el clasificador KNN
%KNN devuelve los K valores m�s cercanos seg�n la distancia euclidiana
knnModel = fitcknn(learnDB, learnGT,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,testDB);
end

