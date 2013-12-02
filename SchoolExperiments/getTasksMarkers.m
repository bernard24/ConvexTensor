function tasksMarkers=getTasksMarkers(indicators)
tasksMarkers=zeros(length(indicators), prod(indicators));
step=1;
total=1;
for i=1:length(indicators)
    total=total*indicators(i);
    count=step;
    value=1;
    for j=1:prod(indicators)
        tasksMarkers(i,j)=value;
        count=count-1;
        if count==0
            value=mod(value,indicators(i))+1;
            count=step;
        end
    end
    step=total;
end
tasksMarkers=[1:prod(indicators); tasksMarkers];
end
