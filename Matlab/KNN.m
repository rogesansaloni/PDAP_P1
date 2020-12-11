function ypred = KNN(X,Y, Xnew)
%Esta función aplica el clasificador KNN
%KNN devuelve los K valores más cercanos según la distancia euclidiana
knnModel = fitcknn(X,Y,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,Xnew);
end

