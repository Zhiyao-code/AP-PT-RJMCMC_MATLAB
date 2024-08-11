function [nc,ind_zc,zc,xc,p_xc]=death(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c)
global acc attempt
attempt(2,i_c)=attempt(2,i_c)+1;

np=nc-1;

ind_set=2:nc;
ind=randsample(ind_set,1);
if numel(ind_set)==1
ind=ind_set;
end

ind_zp=[ind_zc;nan];ind_zp(ind)=[];
zp=[zc;nan];zp(ind)=[];
xp=[xc;nan];xp(ind)=[];

p_xp=pdf(np,zp,xp);

z_death=zc(ind);
x_death=xc(ind);
x_new_at_zd=curvefitting(np,zp,xp,z_death);

C=2.38^2*(cov_tune(ind_zc(ind),ind_zc(ind))+1e-6);
% C=cov_tune(ind_zc(ind),ind_zc(ind));
log_pro=log_normpdf(x_death,x_new_at_zd,sqrt(C));
log_pri=log(x_max-x_min);
log_lik=(p_xp-p_xc)/Tem;
p_acc=exp(log_pro+log_pri+log_lik);

if p_acc>rand
    [nc,ind_zc,zc,xc,p_xc]=deal(np,ind_zp,zp,xp,p_xp);
    acc(2,i_c)=acc(2,i_c)+1;
end
end