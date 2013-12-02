
d=40;
nIt=1000000;

tic;
for i=1:nIt
    x=rand(1,d);
    y1=proj2sorted(x);
end
toc
tic;
for i=1:nIt
    x=rand(1,d);
    y2=proj2sorted_eff(x);
end
toc
