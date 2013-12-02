
d=40;
nIt=10000;

tic;
for i=1:nIt
    v=proj2sorted_eff(rand(1,d));
    w=proj2sorted_eff(rand(1,d));
    cost(w,v,1);
end
toc
tic;
for i=1:nIt
    v=proj2sorted_eff(rand(1,d));
    w=proj2sorted_eff(rand(1,d));
    cost_eff(w,v,1);
end
toc
