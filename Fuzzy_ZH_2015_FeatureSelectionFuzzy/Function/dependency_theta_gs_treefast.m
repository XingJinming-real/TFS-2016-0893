% compute the generalized dependency with theta-sigma fuzzy rough sets
% Some mistakes are revised by Hong Zhao in 2015-12-15

% 2016/4/23 
function r=dependency_theta_gs_tree(data_array,delta,k,tree,deltaSib)
% clear;clc;
% load zh5120;
% load SAIAPR
% load tree;
% delta = 0.2;
%  k =1;
s=delta;

treeParent=tree(:,1)';
% treeLevel=tree(:,2)';
clear tree;
% treeHeight = max(treeLevel);
[m,n]=size(data_array);
r=0;
x=0;
for i=1:m
    if k==1
%       label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12�ҵ���ǰ�������������о��߲�ͬ�����ҵ�������������
       % ֻ���ֵ�������Ϊ����������Ч��������Ҫ�����еĽ��û���ֵܽ�㣻
       % 2016/4/22���������û���ֵܽ�����ͬ��Ĵ��档 
       label_diff=find(treeParent(data_array(:,n))==treeParent(data_array(i,n)));
      
       %zh100��87�м�¼�Ҳ����ֵܽ��
       len=length(label_diff);
        if(len==1||len>m*deltaSib)%����3
%        if(len==1)
            x=x+1;
              continue;
          % label_diff=find(data_array(:,n)~=data_array(i,n));
       else
            Locate=find(label_diff(:)==i);%    % �󲻳����������Ϊ���Լ�Ҳ���������ˣ��ֵܽ��Ӧ���ǳ����Լ���ͬ���׽��
            label_diff(Locate)=[];%ɾ��ͬ��ǵļ�¼
            label_diff=label_diff';
             leng(i)=length(label_diff); 
       end   

        array_diff=data_array(label_diff,1:n-1);          
        [p,q]=size(array_diff);
        for j=1:p;
 %          array_diff(j,:)=min(array_diff(j,:)-data_array(i,1:n-1),1);%%%%%%%%%% for  nominal attributes
           array_diff(j,:)=min(abs(array_diff(j,:)-data_array(i,1:n-1)),1);% Revised by Hong Zhao in 2015-12-15
        end
%         t=ones(q,1);
        array_diff=array_diff.^2;%����һ��ȥ����Ч�����á�
        %û���ֵܽ���ʱ��value_nearestΪ��ֵ��
        [value_nearest,label_nearest]=min(sum(array_diff,2));
         xxx=sqrt(1-(exp(-value_nearest/2/s)).^2)/m;
         r=r+xxx;
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
        r=r+sqrt(1-(exp(-value_nearest/2/s))^2)/m;
    end
    
end
% x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%