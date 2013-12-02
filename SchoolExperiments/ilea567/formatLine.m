function [X,Y] = formatLine(line, X, Y)

disp('')
length(line)
line
v=zeros(26,1)-1;
year=str2num(line(1));      v(year)=1;
school=str2num(line(2:4));
score=str2num(line(5:6));
fsm=str2num(line(7:8));           v(4)=fsm;
vr1=str2num(line(9:10));          v(5)=vr1;
gender=str2num(line(11));         
if gender==0
    v(6)=1; 
end
vrstudent=str2num(line(12));      v(6+vrstudent)=1;
ethnic=str2num(line(13:14));      v(9+ethnic)=1;
schoolGender=str2num(line(15));   v(20+schoolGender)=1;
schoolDen=str2num(line(16));      v(23+schoolDen)=1;

v'

X{school}=[X{school} v];
Y{school}=[Y{school}; score];
end