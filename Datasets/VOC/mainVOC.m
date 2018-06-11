clear;
clc;
%% Author: HongZhao
%% Date: 2018-1-31
%% VOC ���ݽ�����Ѿ����ԣ���������һ��
%load VOC;
load('anszhVOC220.mat'); %Hierarchical results;
load('indicesVOCoktest2.mat')
load('VOCTest.mat')
knn_k = 5;
[m,n] = size(data_array);
d=[220 60 20];
numFolds = 10;
for i=1:length(d)
    dataMatrix =data_array(:,[feature_slct(1:d(i)),n]);
    [HirAccuracyMean_knn1(i,1),HirAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
    [HirSVM_TIE(i,1), HirSVM_F_LCA(i,1), HirSVM_FH(i,1), HirSVM_accuracyMean(i,1), HirSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
    [HirNBC_TIE(i,1), HirNBC_F_LCA(i,1), HirNBC_FH(i,1), HirNBC_accuracyMean(i,1), HirNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);
end
i = i+1;
   dataMatrix =data_array;
    [HirAccuracyMean_knn1(i,1),HirAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
    [HirSVM_TIE(i,1), HirSVM_F_LCA(i,1), HirSVM_FH(i,1), HirSVM_accuracyMean(i,1), HirSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
    [HirNBC_TIE(i,1), HirNBC_F_LCA(i,1), HirNBC_FH(i,1), HirNBC_accuracyMean(i,1), HirNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);

%% Flat Results
load('anshuVOC100.mat');%Flat results,ֻѡ��ǰ101����ʣ119������������ѡ��220����
dataMatrix = data_array(:,[feature_slct,feature_lft,n]);
i = 1;
[FlatAccuracyMean_knn1(i,1),FlatAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
[FlatSVM_TIE(i,1), FlatSVM_F_LCA(i,1), FlatSVM_FH(i,1), FlatSVM_accuracyMean(i,1), FlatSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
[FlatNBC_TIE(i,1), FlatNBC_F_LCA(i,1), FlatNBC_FH(i,1), FlatNBC_accuracyMean(i,1), FlatNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);
d = [60 20];
i = 2;
dataMatrix = data_array(:,[feature_slct(1:d(1)),n]);
[FlatAccuracyMean_knn1(i,1),FlatAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
[FlatSVM_TIE(i,1), FlatSVM_F_LCA(i,1), FlatSVM_FH(i,1), FlatSVM_accuracyMean(i,1), FlatSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
[FlatNBC_TIE(i,1), FlatNBC_F_LCA(i,1), FlatNBC_FH(i,1), FlatNBC_accuracyMean(i,1), FlatNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);
i = 3;
dataMatrix = data_array(:,[feature_slct(1:d(2)),n]);
[FlatAccuracyMean_knn1(i,1),FlatAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
[FlatSVM_TIE(i,1), FlatSVM_F_LCA(i,1), FlatSVM_FH(i,1), FlatSVM_accuracyMean(i,1), FlatSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
[FlatNBC_TIE(i,1), FlatNBC_F_LCA(i,1), FlatNBC_FH(i,1), FlatNBC_accuracyMean(i,1), FlatNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);

save resultVOCall