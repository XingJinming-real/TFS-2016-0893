% compute the generalized dependency with S-T fuzzy rough sets
% Some mistakes are revised by Hong Zhao in 2015-12-15
% �����������������𵽵����÷ǳ�����������������ַ�������һ���á�
% 2016-4-20�������ṹ��
% tree�����ṹ����һ���Ǹ����ı�ţ��ڶ��������ڲ�ı��
function r=dependency_s_gs_tree(data_array,delta,k,tree)
treeParent=tree(:,1)';
% treeLevel=tree(:,2)';
clear tree;
% treeHeight = max(treeLevel);
s=delta;
[m,n]=size(data_array);
r=0;
for i=1:m
    if k==1
       %%
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
        array_diff=data_array(label_diff,1:n-1);%����������������������array_diff��
        [p,q]=size(array_diff);
        for j=1:p%�������i�������ľ��룬����������1����1����
%          array_diff(j,:)=min(array_diff(j,:)-data_array(i,1:n-1),1);%%%%%%%%%% for  nominal attributes
           array_diff(j,:)=min(abs(array_diff(j,:)-data_array(i,1:n-1)),1);% Revised by Hong Zhao in 2015-12-15
        end
      %  t=ones(q,1); %Deleted by Hong Zhao in 2015-12-15
        array_diff=array_diff.^2;
        [value_nearest,label_nearest]=min(sum(array_diff,2));%ÿһ����ͣ�Ȼ������Сֵ
        r=r+(1-(exp(-value_nearest/2/s)))/m;% Revised by Hong Zhao in 2015-12-15
      %  r=r+(1-(exp(-value_nearest/2/s^2)))/m;% Written by HQH
    else
        label_diff=find(data_array(:,n)~=data_array(i,n));
        array_diff=data_array(label_diff,1:n-1);
        [p,q]=size(array_diff);
        for j=1:p;
            temp(j,:)=min(abs(array_diff(j,:)-data_array(i,1:n-1)),1);%%%%%%%%%% for  nominal attributes
        end
        d=temp.^2;
        [x,y]=sort(sum(d,2));
        temp=median(array_diff(y(1:k),:));
        value_nearest=sum((data_array(i,1:n-1)-temp).^2);
        r=r+(1-(exp(-value_nearest/2/s)))/m;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%