function [n,z,x,p_x]=AP_PT_RJMCMC(pdf,R,T,l,nn,N)
global attempt acc s_att s_acc 
attempt=ones(3,N);acc=ones(3,N);s_att=zeros(1,N); s_acc=zeros(1,N);

n_min=R(1,1);n_max=R(1,2);x_min=R(2,1);x_max=R(2,2);coord=linspace(l(1),l(2),nn);
q=@(C,d)mvnrnd(zeros(1,d),C);

n=nan(T,1);z=nan(T,n_max);x=nan(T,n_max);p_x=nan(T,1);

%%%%% Temperature
Tem=10.^(3*((1:N)-1)./(N-1));
%%%%%%

[Nc,ind_Zc,Xc]=prior(n_max,x_min,x_max,nn,N);
Zc=nan(n_max,N);Zc(1:Nc,:)=coord(ind_Zc(1:Nc,:));
p_Xc=nan(1,N);

tune=500;
load_tune=nan(tune,nn,N);

for i=1:N
    p_Xc(i)=pdf(Nc(i),Zc(:,i),Xc(:,i));
    load_tune(1,:,i)=curvefitting(Nc(i),Zc(:,i),Xc(:,i),coord);
end

%%%%%store the initial state
n(1)=Nc(1);z(1,:)=Zc(:,1)';x(1,:)=Xc(:,1)';p_x(1)=p_Xc(1);

for t=2:tune
    for i=1:N
        [Nc(i),ind_Zc(:,i),Zc(:,i),Xc(:,i),p_Xc(i),move_mode]=C_mainRJ(Nc(i),ind_Zc(:,i),Zc(:,i),Xc(:,i),p_Xc(i),n_min,n_max,x_min,x_max,q,pdf,coord,1,t,tune,Tem(i),i);
        load_tune(t,:,i)=curvefitting(Nc(i),Zc(:,i),Xc(:,i),coord);
    end
    n(t)=Nc(1);z(t,:)=Zc(:,1)';x(t,:)=Xc(:,1)';p_x(t)=p_Xc(1);
    %%%swap
    [Nc,ind_Zc,Zc,Xc,p_Xc]=non_Re_tem_swap(Nc,ind_Zc,Zc,Xc,p_Xc,Tem,N,t);
end

%%%%%%covariance history
cov_tune=nan(nn,nn,N);mean_tune=nan(1,nn,N);
for i=1:N
    cov_tune(:,:,i)=cov(load_tune(:,:,i));mean_tune(:,:,i)=mean(load_tune(:,:,i));
end

for t=tune+1:T
    for i=1:N
        [Nc(i),ind_Zc(:,i),Zc(:,i),Xc(:,i),p_Xc(i),move_mode]=mainRJ(Nc(i),ind_Zc(:,i),Zc(:,i),Xc(:,i),p_Xc(i),n_min,n_max,x_min,x_max,q,pdf,coord,cov_tune(:,:,i),t,tune,Tem(i),i);
        load_c=curvefitting(Nc(i),Zc(:,i),Xc(:,i),coord);
        [cov_tune(:,:,i),mean_tune(:,:,i)]=ite_C(cov_tune(:,:,i),mean_tune(:,:,i),load_c,t-1);
    end
    n(t)=Nc(1);z(t,:)=Zc(:,1)';x(t,:)=Xc(:,1)';p_x(t)=p_Xc(1);
    
    [Nc,ind_Zc,Zc,Xc,p_Xc]=non_Re_tem_swap(Nc,ind_Zc,Zc,Xc,p_Xc,Tem,N,t);
    
    if t<1e5  %%%%%%%%%warm-up
    if mod(t,1000)==0
       moni1=s_acc./s_att<0.1;
       moni1=[false,moni1(1:end-1)];
       Tem(moni1)=Tem(moni1)*0.99;
       moni2=s_acc./s_att>0.4;
       moni2=[false,moni2(1:end-1)];
       Tem(moni2)=Tem(moni2)*1.01;       
    end
    end
    
    if mod(t,10000)==0
        disp(t);disp(acc./attempt);disp(s_acc./s_att);disp(Tem)
    end
end

    