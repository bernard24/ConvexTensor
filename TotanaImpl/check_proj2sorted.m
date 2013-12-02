
d=4;
x=rand(d,1)
[ y ] = proj2sorted_eff( x );

record=norm(x-y)

randRecord=Inf;
for i=1:1000000
    z=rand(d,1);
    z=sort(z, 'descend');
    attempt=norm(x-z);
    if attempt<randRecord
        randRecord=attempt;
    end
end

randRecord