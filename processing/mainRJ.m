function [nc,ind_zc,zc,xc,p_xc,move_mod]=mainRJ(nc,ind_zc,zc,xc,p_xc,n_min,n_max,x_min,x_max,q,pdf,coord,cov_tune,t,tune,Tem,i_c)

judge=rand();
move_mod=0;
if nc==n_min
    [nc,ind_zc,zc,xc,p_xc]=birth(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c);
else if nc==n_max
        [nc,ind_zc,zc,xc,p_xc]=death(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c);
    else if judge<=1/3
            [nc,ind_zc,zc,xc,p_xc]=move(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,cov_tune,t,tune,Tem,i_c);move_mod=1;
        else if judge<=2/3
                [nc,ind_zc,zc,xc,p_xc]=birth(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c);
            else
                [nc,ind_zc,zc,xc,p_xc]=death(nc,ind_zc,zc,xc,p_xc,x_min,x_max,q,pdf,coord,cov_tune,Tem,i_c);
            end
        end
    end
end
end
    
    