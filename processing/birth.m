function [nc,ind_zc,zc,xc,p_xc]=birth(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c)
global acc attempt
attempt(1,i_c)=attempt(1,i_c)+1;

np=nc+1;
NN=1:numel(coord);
ind_set=NN(~ismember(NN,ind_zc));
ind_znew=randsample(ind_set,1);
if numel(ind_set)==1
    ind_znew=ind_set;
end
ind=find(ind_zc>ind_znew,1);
if isempty(ind)
    ind=np;
end
ind_zp=[ind_zc(1:(ind-1));ind_znew;ind_zc(ind:(end-1))];

z_new=coord(ind_znew);
zp=[zc(1:(ind-1));z_new;zc(ind:(end-1))];

C=2.38^2*(cov_tune(ind_znew,ind_znew)+1e-6);
% C=cov_tune(ind_znew,ind_znew);
x_old=curvefitting(nc,zc,xc,z_new);
x_new=x_old+q(C,1);
xp=[xc(1:(ind-1));x_new;xc(ind:(end-1))];

if ~((x_new<x_min)|(x_new>x_max))
    p_xp=pdf(np,zp,xp);    
else return
end

log_pro=-log_normpdf(x_new,x_old,sqrt(C));
log_pri=-log(x_max-x_min);
log_lik=(p_xp-p_xc)/Tem;
p_acc=exp(log_pro+log_pri+log_lik);

if p_acc>rand
    [nc,ind_zc,zc,xc,p_xc]=deal(np,ind_zp,zp,xp,p_xp);
    acc(1,i_c)=acc(1,i_c)+1;
end

end



