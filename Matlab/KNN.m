function ypred = KNN(featuresLearn,labelsLearn,featuresTest)
%Esta función aplica el clasificador KNN
%KNN devuelve los K valores más cercanos según la distancia euclidiana
knnModel = fitcknn(featuresLearn, labelsLearn,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,featuresTest);
end

