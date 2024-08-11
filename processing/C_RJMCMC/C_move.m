function [nc,ind_zc,zc,xc,p_xc]=C_move(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,cov_tune,t,tune,Tem,i_c)
global acc attempt scale_factor
attempt(3,i_c)=attempt(3,i_c)+1;
np=nc;ind_zp=ind_zc;zp=zc;

C=(2.38/(sqrt(np)))^2*eye(np)+1e-6*eye(np);

if t>tune
C=scale_factor(i_c)*C;
end

xp=xc;xp(1:np)=xp(1:np)+q(C,np)';

if ~((xp(:,:)<x_min)|(xp(:,:)>x_max))
    p_xp=pdf(np,zp,xp);
    p_acc=exp((p_xp-p_xc)/Tem);
else return
end


if p_acc>rand
    [nc,ind_zc,zc,xc,p_xc]=deal(np,ind_zp,zp,xp,p_xp);
    acc(3,i_c)=acc(3,i_c)+1;
end
end