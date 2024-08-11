function y=curvefitting(n,z,x,coord)
ni=n;
xi=x(1:ni)';
zi=z(1:ni);
y=xi*((coord>=zi).*[(coord<zi(2:end));ones(1,numel(coord))]);
end

%%%%%%%%% piecewise constant in this case.

%%%   you can use  piecewise linear or spline by using the following:
%%%%   y=interp1(zi,xi,coord); or y=spline(zi,xi,coord);