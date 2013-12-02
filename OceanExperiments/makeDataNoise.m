function [dataConf DataParameters] = makeDataNoise(~, DataParameters) 
%MAKEDATA Summary of this function goes here
%   Detailed explanation goes here

noise=DataParameters.noise;

cd ocean/org
listImages=ls('*.png');
im=imread(listImages(1,:));

dimsTensor=[length(listImages), size(im)];
T=zeros(dimsTensor);
originalT=zeros(dimsTensor);
KnownInputs=zeros(dimsTensor);
for i=0:length(listImages)-1
    nameFile=[ 'c' num2str(i) '.png'];
    im=double(imread(nameFile));
    originalT(i+1,:,:,:)=im;
    im2=im+randn(size(im))*noise;
    T(i+1,:,:,:)=im2;
    mark=im<256;
    KnownInputs(i+1,:,:,:)=mark;
end
RSE=norm(T(1:end)-originalT(1:end))/norm(originalT(1:end))

dataConf.originalTensor=tensor(originalT);
dataConf.Tensor=tensor(T);
dataConf.KnownInputs=tensor(KnownInputs);
cd ../..

end
