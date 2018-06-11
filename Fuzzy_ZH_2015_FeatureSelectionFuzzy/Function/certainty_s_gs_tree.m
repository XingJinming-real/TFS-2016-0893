% compute the generalized classification certainty with S-T fuzzy rough sets
% Date: 2016-5-5
% Author: Hong Zhao
function r=certainty_s_gs_tree(data_array,delta,k,tree)
s=delta;
[m,n]=size(data_array);
treeParent=tree(:,1)';
%%%%%%%%%%% find the labels of classes%%%%%%
D=data_array(:,n);%the value of the decision 
dv=[];
while length(D)~=0 %�ҵ���������ǩ
    dv=[dv; D(1)];
    label=find(D==D(1));     
    D(label)=[];   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D=dv;
% D=data_array(:,n);
r=0;
for i=1:m
%     label_diff=find(data_array(:,n)~=data_array(i,n));
%% Witten by Hong Zhao
       x1=treeParent(data_array(:,n))==treeParent(data_array(i,n));
       x2=data_array(:,n)~=data_array(i,n);
       label_diff=find(x1'&x2);%��ͬ���׽ڵ�ķǱ����������
       label_diff=label_diff';       
       %���ܻ����û���ֵܵ�������Ŀǰ�������������10������������������
       len=length(label_diff);
       if(len==0)
           label_diff=find(data_array(1:round(m/10):m,n)~=data_array(i,n));
       end
       %%
    temp_l=length(label_diff);
    temp_dist=sum((repmat(data_array(i,1:(n-1)),temp_l,1)-data_array(label_diff,1:(n-1))).^2, 2);
    temp=sort(temp_dist);%����
    M=temp(1:k);
    LA=sum(ones(size(M))-exp(-M/delta));
    UA=0;
%     length(D)
%2016-5-9��δ��������⣬�Ͻ��Ƹ�����û����
% D=dv;%��Ҫ�������
    for j=1:length(D)
        %fprintf('***********\n');
        UP=0;
        if data_array(i,n)~=D(j)%��ͬ��ĲŻ���㣬ͬ����Ͻ���Ϊ1.
            label_diff=find(data_array(:,n)==D(j));
            temp_l=length(label_diff);
%             temp_m= repmat(data_array(i,n),label_diff,1);%huqinghua
            temp_dist=sum((repmat(data_array(i,1:(n-1)),temp_l,1)-data_array(label_diff,1:(n-1))).^2, 2);
            temp=sort(temp_dist);
            M=temp(1:k); %�󲿷���0
          
            UP=exp(-M/delta);
         end
        if(UP<1)
        UA=UA+sum(UP);
        end
    end
    CC(i)=(LA-UA)/k;
 end
r=sum(CC)/m;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%function diff=num_diff(a) 

