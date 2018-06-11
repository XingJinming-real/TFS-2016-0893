clear;
clc;
%% Author: HongZhao
%% Date:2018-1-31
%% SAIAPR ���ݽ�����Ѿ����ԣ���������һ��
%% Hierarhcical results;
load('News20GroupTrain.mat')
load('indicesNews21.mat');
[m,n]=size(data_array);
%   rand('seed',5);
numFolds = 10;
%   indices = crossvalind('Kfold',m,numFolds);%//��������ְ� for k=1:10//������֤k=10��10����������Ϊ���Լ�
load('anszhNews501.mat');
d = [500 40 30];
knn_k = 5;
for i = 1:length(d)
    dataMatrix = data_array(:,[feature_slct(1:d(i)),n]);
    [HirAccuracyMean_knn1(i,1),HirAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
    [HirSVM_TIE(i,1), HirSVM_F_LCA(i,1), HirSVM_FH(i,1), HirSVM_accuracyMean(i,1), HirSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
    [HirNBC_TIE(i,1), HirNBC_F_LCA(i,1), HirNBC_FH(i,1), HirNBC_accuracyMean(i,1), HirNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);
end
i = i+1;
dataMatrix =data_array;
[HirAccuracyMean_knn1(i,1),HirAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
[HirSVM_TIE(i,1), HirSVM_F_LCA(i,1), HirSVM_FH(i,1), HirSVM_accuracyMean(i,1), HirSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
[HirNBC_TIE(i,1), HirNBC_F_LCA(i,1), HirNBC_FH(i,1), HirNBC_accuracyMean(i,1), HirNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);


%% Flat results;��Ϊѡ��������������ֻѡ��ǰ������һ��ɾ���˶��������ʣ��102�����ͼ�����Щ���Ǳ�ѡ������
load('anshunews40.mat');%ֻѡ��������ʣ�µ�99�����ǵ�һ��δ��ɾ��������
d = [40 30];
% dataMatrix = data_array(:,[feature_slct,n]);
for i = 1:length(d)
    dataMatrix = data_array(:,[feature_slct(1:d(i)),n]);
    [FlatAccuracyMean_knn1(i,1),FlatAccuracyStd_knn1(i,1)] = Kflod_multclass_knn(dataMatrix,numFolds,indices,tree,knn_k);
    [FlatSVM_TIE(i,1), FlatSVM_F_LCA(i,1), FlatSVM_FH(i,1), FlatSVM_accuracyMean(i,1), FlatSVM_accuracyStd(i,1)] = Kflod_multclass_svm_testHierarchy(dataMatrix,numFolds,2,indices,tree);
    [FlatNBC_TIE(i,1), FlatNBC_F_LCA(i,1), FlatNBC_FH(i,1), FlatNBC_accuracyMean(i,1), FlatNBC_accuracyStd(i,1)] = Kflod_NBC_testHierarchy(dataMatrix,numFolds,indices,tree);
end
clear data_array;
save resultNews180204