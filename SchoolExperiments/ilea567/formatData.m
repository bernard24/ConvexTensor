fid=fopen('ILEA567.DAT');
line=fgetl(fid);

X=cell(1,139);
Y=cell(1,139);
for i=1:139
    X{i}=[];
    Y{i}=[];
end 
while length(line)>0
    [X,Y]=formatLine(line,X,Y);
    line=fgetl(fid);
end
