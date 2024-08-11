function [C_new,mean_new]=ite_C(C_old,mean_old,load_new,t)
t=t-1;
mean_new=(mean_old*t+load_new)/(t+1);
C_new=C_old*(t-1)/t+(mean_old'*mean_old)-(t+1)/t*(mean_new'*mean_new)+(load_new'*load_new)/t;
end

