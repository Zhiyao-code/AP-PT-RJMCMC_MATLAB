function [Nc,ind_Zc,Zc,Xc,p_Xc]=non_Re_tem_swap(Nc,ind_Zc,Zc,Xc,p_Xc,Tem,N,t)
    global s_att s_acc
    for i=1:2:N
        if mod(t,2)==0
            swap_i=i;swap_p=i+1;        
        else
            swap_i=i+1;swap_p=i+2; 
            if swap_p==N+1
                swap_p=1;
            end
        end
       
        s_att(swap_i)=s_att(swap_i)+1;
        
        p_acc=exp((1/Tem(swap_i)-1/Tem(swap_p))*(p_Xc(swap_p)-p_Xc(swap_i)));
        if p_acc>rand
            Nc(:,[swap_i,swap_p])=Nc(:,[swap_p,swap_i]);
            Xc(:,[swap_i,swap_p])=Xc(:,[swap_p,swap_i]);
            Zc(:,[swap_i,swap_p])=Zc(:,[swap_p,swap_i]);
            p_Xc(:,[swap_i,swap_p])=p_Xc(:,[swap_p,swap_i]);
            ind_Zc(:,[swap_i,swap_p])=ind_Zc(:,[swap_p,swap_i]);
            
            s_acc(swap_i)=s_acc(swap_i)+1;
            
        end
    end
end