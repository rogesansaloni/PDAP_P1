function ypred = CART(learnDB, learnGT, testDB)
%Esta función aplica el clasificador CART.
%CART utiliza preguntas binarias para determinar en que parte de un mapa de dos
%dimensiones se encuentra cierto valor. Para ello se crea un diagrama en
%forma de regression tree.
treeModel = fitctree(learnDB, learnGT);
ypred = predict(treeModel,testDB);
end

