function l_mp=load_density_map(post_n,post_x,post_z,l,nn,y_min,y_max)
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
[l_mp,le1]=map_density(x0,load_p,y_min,y_max);
hold on 
load data_tune1.mat
le=plot(data(1,:),data(2,:),'*','Color',[0 0.45 0.74]);
% hold on
% plot(x0,sin(2*x0)+2*exp(-16*x0.^2),'LineWidth',1,'color','r')
end

