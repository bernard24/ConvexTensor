function [dataConf DataParameters] = makeData(~, DataParameters) 
%MAKEDATA Summary of this function goes here
%   Detailed explanation goes here

sizeIm=[112 160 3];

noise=DataParameters.noise;

cd ocean/org
listImages=dir('*.png');

% im=imread(listImages(1,:));
% inputsPerImage=prod(size(im));
inputsPerImage=prod(sizeIm);
unknownInputsPerc=DataParameters.unknownPerc;
unknownInputsPerImage=floor(unknownInputsPerc*inputsPerImage);

dimsTensor=[length(listImages), sizeIm];
T=zeros(dimsTensor);
KnownInputs=zeros(dimsTensor);
originalT=zeros(dimsTensor);
for i=0:length(listImages)-1
    nameFile=[ 'c' num2str(i) '.png'];
    im=imread(nameFile);
%     im=im(21:20+sizeIm(1), 21:20+sizeIm(2), 1:sizeIm(3));
    originalT(i+1,:,:,:)=double(im);
    im=double(im)+randn(size(im))*noise;
    
    newOrder=randperm(inputsPerImage);
    im2=im;
    im2(newOrder(1:unknownInputsPerImage))=0;
    known=zeros(size(im));
    known(newOrder(unknownInputsPerImage+1:end))=1;
    T(i+1,:,:,:)=double(im2);
    KnownInputs(i+1,:,:,:)=known;
end

meanOriginalT=mean(originalT(1:end));
originalT=originalT-meanOriginalT;

originalT=originalT/256;
%
T=T-meanOriginalT;
T=T/256;

for i=1:4
    mat=tenmat(originalT, i);
    [u l v]=mySVD(mat.data);
    max(diag(l))
end

norm(mat.data, 'fro')

dataConf.originalTensor=tensor(originalT);
dataConf.KnownInputs=tensor(KnownInputs);
dataConf.Tensor=tensor(T);
cd ../..

end
