function ypred = KNN(learnDB, learnGT, testDB, k)
%Esta funci�n aplica el clasificador KNN
%KNN devuelve los K valores m�s cercanos seg�n la distancia euclidiana
knnModel = fitcknn(learnDB, learnGT,'NumNeighbors',k,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,testDB);
end

