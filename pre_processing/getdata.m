data=[];
data(1,:)=0:0.5:10;
x=[30,-50,-20,82,-10,-41];
y=curvefitting(x,data);
data(2,:)=y+normrnd(0,5,1,numel(y));

plot(data(1,:),y);
hold on
plot(data(1,:),data(2,:),'r*')