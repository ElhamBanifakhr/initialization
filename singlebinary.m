function f= singlebinary(x,W)
s=1:73;
x1=zeros(1,length(x));
for i=1:length(x)
        if x(i)~=0
           x1(i)=s(i);
        else
            x1(i)=0;
        end
end
  x1(x1==0)=[];
  x=x1;
    if sum(x)~=0
%         f(1)=mean(min(W{1}(:,x),[],2));
        f(1)=max(min(W{1}(:,x),[],2));
    else
        f=inf;
%         f=[inf inf];
    end
%     Pen=138808;
    y=size(x,2);
    if y>10
        Pen=1388080000000000000;
    else
        Pen=0;
    end
%     Pen=(sum((y-1).^10.*heaviside(y-1)));
    f=f+Pen; 
    NS=x;
end