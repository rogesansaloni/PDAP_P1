function ypred = CART(X,Y, Xnew)
%Esta función aplica el clasificador CART.
%CART utiliza preguntas binarias para determinar en que parte de un mapa de dos
%dimensiones se encuentra cierto valor. Para ello se crea un diagrama en
%forma de regression tree.
treeModel = fitctree(X,Y);
ypred = predict(treeModel,Xnew);
view(treeModel,'Mode','graph') 
end

