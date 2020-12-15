function ypred = KNN(featuresLearn,labelsLearn,featuresTest)
%Esta funci�n aplica el clasificador KNN
%KNN devuelve los K valores m�s cercanos seg�n la distancia euclidiana
knnModel = fitcknn(featuresLearn, labelsLearn,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,featuresTest);
end

