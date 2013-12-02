d=40;
lambda=0.1;
nIt=10;

tic;
for i=1:nIt
    v=proj2sorted_eff(rand(d,1));
    [ record1 bestW bestR ] = proxSubGradient( v, lambda );
end
toc
tic;
for i=1:nIt
    v=proj2sorted_eff(rand(d,1));
    [ record bestW bestR ] = proxSubGradient_eff( v, lambda );
end
toc
