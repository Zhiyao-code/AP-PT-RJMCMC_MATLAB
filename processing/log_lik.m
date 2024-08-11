function ll=log_lik(n,z,x,data)
y_fit=curvefitting(n,z,x,data(1,:));
error=y_fit-data(2,:);
logpdf=-error.^2/50;
ll=sum(logpdf);
end
