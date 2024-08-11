addpath(genpath('D:\.......'));%%%%%please use your own path to include the entire package
rng('shuffle');

T=2000000;nn=101;l=[0 10];N=10;   %%%%%%% enter your chain steps/candidate nodes numebr/defination domain/chain numbers
global scale_factor sc
scale_factor=ones(1,N);
sc=nan(T,N);

n_min=2;n_max=nn;
x_min=-300;x_max=300;        %%%%%%%%%%enter your prior information, U(-300,300) in this case
R=[n_min,n_max;x_min,x_max];

load('data.mat');       %%%%%%%%%%use your own data, piecewise constant in this case. you should modify "curveftting.m" if you want to use spline or piecewice lienar
pdf=@(n,z,x)log_lik(n,z,x,data);   %%%%%%%%%%%%%%%use your likelihood function,  piecewise constant in this case.


[n,z,x,p_x]=AP_PT_RJMCMC(pdf,R,T,l,nn,N);

figure 
plot(n);
figure
plot(p_x(end/2:end,:));

post_n=n(end/2:end,1);
post_x=x(end/2:end,:,1);
post_z=z(end/2:end,:,1);

figure 
histogram(post_n);
figure 
plot(post_n);

l_mp=load_density_map(post_n,post_x,post_z,l,nn,-500,500);
% ylim([-3 4]);

