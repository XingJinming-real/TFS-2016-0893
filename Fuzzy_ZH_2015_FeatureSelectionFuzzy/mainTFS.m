clc;clear;
%����1������ȡ100����¼��200����¼����ʵ�飻
%����2����ʾ��һ�μ���������Ҫ�ȵĽ������һЩ�ر�С������ֱ��ɾ���������ڶ��μ��㣻��Ϊ����ϡ�裬���ַ�������Ч
%����3��deltaSib = 0.1;%1000���������ֵܽ���������100�Ͳ������ˡ�
%����4��2016-4-24 21:21 �ֵܽ����������ֱ��ɾ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%����A0.1+B+D0.01
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str1 = {'Bridges','VOCTrain','News20GroupTrain','SAIAPRok5000'};
numSelectedFeature1 = [10, 60, 40, 40];
delta = 0.2;
k = 1;
evaluator = 'GD_S_tree';
for i=1:length(str1)
    load (str1{i});
    numSelectedFeature = numSelectedFeature1(i);
    [feature_slct,feature_lft,tx]=FS_GKFS_TREE(data_array, tree, evaluator, delta, k, numSelectedFeature);
    clear data_array;
    filename = ['ansHir' str1{i}];
    save(filename);
end

evaluator = 'GD_S';
for i=1:length(str1)
    load (str1{i});
    numSelectedFeature = numSelectedFeature1(i);
    [feature_slct,feature_lft,tx]=FS_GKFS_TREE(data_array, tree, evaluator, delta, k, numSelectedFeature);
    clear data_array;
    filename = ['ansFlat' str1{i}];
    save(filename);
end
