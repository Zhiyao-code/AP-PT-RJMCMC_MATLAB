function [Ni,indZi,Xi]=prior(n_max,x_min,x_max,nn,N)
Ni=ones(1,N)*4;
Xi=nan(n_max,N);
indZi=nan(n_max,N);
% [~,draw]=sort(rand(nn,1));
% indzi(1:ni)=[1;sort(draw(1:(ni-1)))];
for i=1:N
    indZi(1:Ni,i)=[1,2,3,4]';% xi(1:ni)=unifrnd(x_min,x_max,ni,1);
    Xi(1:Ni,i)=zeros(Ni(i),1);
end
end