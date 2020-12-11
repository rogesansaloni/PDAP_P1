function ypred = KNN(X,Y, Xnew)
%Esta funci�n aplica el clasificador KNN
%KNN devuelve los K valores m�s cercanos seg�n la distancia euclidiana
knnModel = fitcknn(X,Y,'NumNeighbors',10,'Distance','euclidean','Standardize',1);
ypred = predict(knnModel,Xnew);
end

