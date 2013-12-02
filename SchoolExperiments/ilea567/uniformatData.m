
load schoolData;

preX=[];
preY=[];

for i=1:139
    auxX=X{i};
    auxY=Y{i};
    [josebi year]=max(auxX(1:3,:));
    gender=(auxX(6,:)==1)+1;
    [josebi vrBand]=max(auxX(7:9,:));
    [josebi ethnic]=max(auxX(10:20,:));
    preX=[preX, [ones(1,length(auxY))*i; year; gender; vrBand; ethnic]];
    preY=[preY; auxY];
end
    