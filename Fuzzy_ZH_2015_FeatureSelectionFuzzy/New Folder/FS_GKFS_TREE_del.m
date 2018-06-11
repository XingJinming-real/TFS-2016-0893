%������ʦ���㷨��ֱ�����д˴��뼴�ɡ�
%GW_S,GW_theta�����ַ���Ч�ʸ��ߡ�
%2015-12-16
%2016-4-19�����޸Ĵ��룬���Ч��
%����1�����ȡ100����¼��200����¼����ʵ�飻
%����2����ʾ��һ�μ���������Ҫ�ȵĽ������һЩ�ر�С������ֱ��ɾ���������ڶ��μ��㣻��Ϊ����ϡ�裬���ַ�������Ч
%����3��deltaSib = 0.1;%1000���������ֵܽ���������100�Ͳ������ˡ�
%����4��2016-4-24 21:21 �ֵܽ����������ֱ��ɾ����

% clc;clear;
% delta=0.2;
% s=delta;
% load zh1000;
% load tree;
% deltaSib = 0.01;%0.005;%1000���������ֵܽ���������100�Ͳ������ˡ�
% % deltaDelFeature = 0.1; %ɾ��������Ҫ�ȵ�ֵ<0.1*max_efc(1),ɾ�����Ƚϴ�512���������ɾ��408��
% numSelectedFeature = 40;
%  k=1;

%���ӽṹ��Ϣ
function [feature_slct,feature_lft,sig_s, sig_a,tx,leng]=FS_GKFS_TREE_del(data_array,tree,evaluator, delta, k,numSelectedFeature)
% Feature selection based on kernerlized fuzzy rough sets;
% data_array is the input data with a decision attribute, where a row is a sample, and a column is a feature;  
% Please transform the data into the unit interval [0, 1] before use this algorithm.
% evaluator is to specify the evaluating measures, which take values from  { 'GD_S', 'GD_theta','GW_S','GW_theta'}
% where GD_S means generalized dependency function based on S-T model
%           GD_theta means generalized dependency function based on theta-eta model
%           GW_S means generalized classification certainty function based on S-T model
%           GW_S means generalized classification certainty function based on theta-sigma model
% delta is the kernel parameter, and K is the number of the nearest samples to compute the evaluating measure
% feature_slct is the label of the selected features 
% sig_s��the significance of a single feature
% sig_a��the significance of the selected feature subset

% 19-12-2007, In the Hongkong Polytechnic University, Qinghua Hu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%����A0.1+B+D0.01
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%Change the parameters, you can select different algorithms.

%load News20Home
%data=News20Home;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load SAIAPR;
% load AWAphog-10
% load AWA100;
% deltaSib = 0.01;%0.005;%1000���������ֵܽ���������100�Ͳ������ˡ�
% % deltaDelFeature = 0.1; %ɾ��������Ҫ�ȵ�ֵ<0.1*max_efc(1),ɾ�����Ƚϴ�512���������ɾ��408��
% numSelectedFeature = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load zhVoc500;
% load treeVoc;
% deltaSib = 0.1;%1000���������ֵܽ���������100�Ͳ������ˡ�
% % deltaDelFeature = 0.2; %ɾ��������Ҫ�ȵ�ֵ<0.1*max_efc(1),ɾ�����Ƚϴ�512���������ɾ��408��
% numSelectedFeature = 40;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load glass;%
% deltaSib = 1;%����ɾ���ֵܽ�㡣
% deltaDelFeature = 0.001; %��ɾ�����ԡ�
% numSelectedFeature = 7;%66%��ȷ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load wdbc;
% deltaSib = 1;%����ɾ���ֵܽ�㡣96.8358%���ٶ�̫���ˡ�
% deltaDelFeature = 0.001; %��ɾ�����ԡ�
% numSelectedFeature = 5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
treeParent=tree(:,1)';
tic;
[m,n]=size(data_array);
data=data_array;
len=zeros(1,m);
for i=1:m
   
%       label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12�ҵ���ǰ�������������о��߲�ͬ�����ҵ�������������
       % ֻ���ֵ�������Ϊ����������Ч��������Ҫ�����еĽ��û���ֵܽ�㣻
       % 2016/4/22���������û���ֵܽ�����ͬ��Ĵ��档 2016/04/24����Ҫ�������ˣ����ݼ��������£��������������
       label_diff=find(treeParent(data_array(:,n))==treeParent(data_array(i,n)));
%         leng(i)=length(label_diff); 
       %zh100��87�м�¼�Ҳ����ֵܽ��
       len(i)=length(label_diff);       
end
% % ���ݼ�����һ��
for i=m:-2:1
%     if((len(i)==1||len(i)>m*deltaSib))
    if(len(i)>20)
        len(i)=len(i)-1;
        data_array(i,:)=[];
     end
end

toc
  

% %%
% 
% % data = data_array ;
% % clear data;
[m,n]=size(data_array)
% m
data_array=full(data_array);
feature_slct=[];%��ѡ����
sig=0;
feature_lft=(1:n-1);%[1,2,3,4...,n]��ѡ����
array_cur=[];
num_cur=0;
index =0;
x=0;
%  fprintf('***********');
% evaluator='GD_S'; %'GD_S_tree','GD_theta','GW_S', 'GW_theta'
% evaluator='GD_S_tree'
% evaluator='GD_theta_tree';
% evaluator='GW_theta'%������Ͻ��Ƶķ����ǲ������еġ�
 while num_cur<n-1 
    x=x+1;
    if num_cur==0
        array_cur=[];
    else
        array_cur(:,num_cur)=data_array(:,feature_slct(num_cur));% add the new feature%һ��һ�м���ȥ
    end
    %compute the significance of features
    efc_tmp=[];
    for i=1:length(feature_lft)
        array_tmp=array_cur;
        array_tmp(:,[num_cur+1,num_cur+2])=data_array(:,[feature_lft(i),n]);%ѡ��ǰ�к;�����%�ڵ�ǰ��ѡ���ԵĻ���������һ�У�ʣ�¼����е�����һһʵ�飩��ѡ˭�ĸı����󣬾�ѡ˭
        switch evaluator
            case 'GD_S_tree'
               efc_tmp(i)=dependency_s_gs_treeokmodify(array_tmp,delta,k,tree);
            case 'GD_theta_tree'
                 efc_tmp(i)=dependency_theta_gs_treemodify(array_tmp,delta,k,tree);
%                   efc_tmp(i)=dependency_theta_gs(array_tmp,delta,k);
            case 'GD_S'
                efc_tmp(i)=dependency_s_gs(array_tmp,delta,k);
            case 'GD_theta'
                efc_tmp(i)=certainty_theta_gs(array_tmp,delta,k);
          end  
    end
%   %%%%select the best feature%%%%%%%%%%%%%%%%%%%%%%%%
numSelected = 1;
    if x==1
        sig_s= efc_tmp;
     end
%       [max_efc,max_sequence1]=max(efc_tmp); %ѡ��Ҫ������ֵmax_efc����λ��max_sequence1
      mean_efc_tmp=mean(efc_tmp);
%       [max_efc,max_sequence1]=FirstNMax(efc_tmp,numSelected); %ѡ��Ҫ������ǰ5��ֵmax_efc����λ��max_sequence1
     [max_efc,max_sequence1]=max(efc_tmp); %ѡ��Ҫ������ֵmax_efc����λ��max_sequence1
     if (num_cur>numSelectedFeature & max_efc-sig(num_cur)<0.01) | length(feature_lft)<1 %������Ҫ���㵽����ʱ��ֹͣ[0.418869821071739,0.714568590420625,0.856467908020756,0.880259186664473]
%Hongzhao,2016/4/20,num_cur>10��֤ѡ�����Ը�������Ϊ�е����ݼ����ڶ������Ե�������Ҫ��С����������ֻ���
          num_cur=n-1;
      elseif max_efc>0 | num_cur>0
          index = index + 1;
          for l = 1 : numSelected
              
             num_cur=num_cur+1;
             sig(num_cur)=max_efc(l);
             feature_slct(num_cur)=feature_lft(max_sequence1(l));
             feature_lft(max_sequence1(l))=[];%ɾ����ѡ��
             efc_tmp(max_sequence1(l))=[];%ɾ����ѡ��
          end
     %����2��ɾ��û�б�Ҫ��������ԣ�
%              [x,y]=find(efc_tmp<deltaDelFeature*max_efc(1));%Voc���ݼ������ַ���ֻɾ��һ�����ԣ����������������Ҫ���ò���
              if (index<2 & length(feature_lft)>50)
                  [x,y]=find(efc_tmp<mean_efc_tmp); %���Ը������ַ�����һ�¡�
                  feature_lft(y)=[];    
                  leng(index)=length(y);
              else
                  leng(index)=0;
              end
              
             tx(index)=toc
     else
              num_cur=n-1-leng(index);
       end
 end
sig_a=sig;
 tx(length(tx)+1)=toc;
%  answer=[feature_slct;sig_a];
 
end
%�����һ�£�������һ�ִ���

% for i=1:length(label_test)
% lengtest=evaluateHierarchy(label_test,label_predict,tree)

% label_predict