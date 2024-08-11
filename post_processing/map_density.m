function [cd,le1]=map_density(x,y,y_min,y_max)
x_plot=x;y_plot=linspace(y_min,y_max,1000);percent=nan(numel(y_plot),numel(x_plot));
for i=1:(numel(x)-1)
    yi=y(:,i);
    [N,edges]=histcounts(yi);    
    y_width=edges(2)-edges(1);
    percent_tem=N/sum(N)/y_width;
    y_tem=edges+y_width/2;
    y_tem=y_tem(1:end-1);
    percent_int=interp1(y_tem,percent_tem,y_plot,'Linear');
    percent_int(isnan(percent_int))=0;
    percent(:,i)=flip(percent_int');  
    if (mod(i,100)==0) disp(i);end
end
percent(:,numel(x))=percent(:,numel(x)-1);
[X,Y]=meshgrid(x_plot,flip(y_plot));
% cd=contourf(X,Y,percent,200,'linestyle','none');
% colorbar
figure
cd=pcolor(X,Y,percent);
shading interp;
colorbar
hold on 
le1=plot(x,mean(y),'k','LineWidth',1);

% % % figure
% % %  i=floor(numel(x)/3);
% % %     yi=y(:,i);
% % %     h0=histogram(yi,'Normalization','probability');    

end