clc;clear;
% load data;
% data_array=data;
load data2_bridges_all;
% load wdbc;
% data_array=wdbc;
tic
% data_array=data_array_flat;
% data_array=data_array_sub;
[m,n]=size(data_array);
[feature_slct,sig_s,sig_a]=FS_GKFS(data_array,'GD_S',0.03,1);
% tic
% [feature_slct,sig_s,sig_a]=FS_GKFS(data_array,'GD_theta',0.03,1);
% t=toc
%����ǿ��������½��ƣ����ݾ��󲻳�������½��ƿ���Ϊ0���Ͻ��ƿ���Ϊ1
% [feature_slct,sig_s,sig_a]=FS_GKFS(data_array,'GW_S',0.03,1);

% [feature_slct,sig_s,sig_a]=FS_GKFS(data_array,'GW_S',0.03,1);

% [feature_slct,sig_s,sig_a]=FS_GKFS(data_array,'GW_theta',0.03,1);
t1=toc
fprintf('The selected feature subset is');
feature_slct

%%
%test
[m,n] = size(data_array);
numFolds =10;
indices = crossvalind('Kfold',data_array(:,n),numFolds);%//��������ְ� for k=1:10//������֤k=10��10����������Ϊ���Լ�
% load indiceswdbc;
i=1;
step=0;
% for i=indexBegin:indexBegin+step
% % % % % ��������
% 
X = data_array(:,feature_slct);
y = data_array(:,n);
% categories=unique(y);%for the array y returns the same values as in y but with no repetitions. Categories will be sorted.
% 
[accuracyMean_selected2,accuracyStd_selected2] = Kflod_multclass_svm_testParameters([X,y],numFolds,i,indices);
fprintf(['A0.1--Accurate rate:',num2str(accuracyMean_selected2),'��', num2str(accuracyStd_selected2),'\n']);%12.5954��12.8267��12.2982��15.0538��11.5385
% end
