function ypred = KNN(learnDB, learnGT, testDB)
%Esta función aplica el clasificador KNN
%KNN devuelve los K valores más cercanos según la distancia euclidiana
knnModel = fitcknn(learnDB, learnGT,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,testDB);
end

