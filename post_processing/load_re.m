function load_p=load_re(post_n,post_x,post_z,l,nn)
x0=linspace(l(1),l(2),nn);
x_length=numel(x0);
T0=numel(post_n);
load_p=nan(T0,x_length);

parfor i=1:1:T0
    coor=post_z(i,:);
    pre=post_x(i,:);
    num=post_n(i);    
    load_p(i,:)=curvefitting(num,coor',pre',x0)
    if mod(i,100000)==0
        disp(i)
    end
end


