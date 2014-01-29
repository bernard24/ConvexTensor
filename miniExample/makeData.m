function [dataConf DataParameters] = makeData(~, DataParameters) 
%MAKEDATA Summary of this function goes here
%   It creates the tensor data using the parameters specified in
%   DataParameter structure:

tensorDims=DataParameters.tensorDims;       % Vector with the dimensions of the tensor
tensorRank=DataParameters.tensorRank;       % Vector with the Tucker ranks of the tensor
frobeniusNorm=DataParameters.FrobeniusNorm; % Frobenius norm of the ground truth tensor
noise=DataParameters.noise;                 % The variance of the Gaussian noise added to the ground truth tensor
unknownPerc=DataParameters.unknownPerc;     % Number of tensor inputs that are unknown.

nModes=length(tensorDims);
U=cell(1,nModes);
for i=1:nModes                              % Factor matrices are sampled
    U{i}=randn(tensorDims(i), tensorRank(i));
end
core = tensor(rand(tensorRank),tensorRank); % Core tensor is generated

KT=ttensor(core, U);
originalT=full(KT);                         % We create the tensor
originalT=originalT-mean(originalT.data(1:end));    % Substract the mean
originalT=originalT/sqrt(sum(originalT.data(1:end).^2))*frobeniusNorm;   % Set Frobenius norm
nElements=prod(tensorDims);
knownRow=[zeros(1,floor(nElements*unknownPerc)) ones(1, nElements-floor(nElements*unknownPerc))];
knownRow=knownRow(randperm(nElements));
KnownInputs=tensor(knownRow,tensorDims);    % Select randomly the known inputs of the tensor

% KnownInputs(1,:,:)=0;

noisyVector=originalT.data(1:end)+randn(1,prod(tensorDims))*noise;
T=tensor(noisyVector, tensorDims);

% for i=1:3
%     mat=tenmat(originalT, i);
%     [u l v]=mySVD(mat.data);
%     disp(['Spectral norm of the ' num2str(i) 'th matricization: ' num2str(max(diag(l)))]);
% end


dataConf.originalTensor=tensor(originalT);
dataConf.validation_originalTensor=tensor(originalT);
dataConf.Tensor=tensor(T);
dataConf.KnownInputs=tensor(KnownInputs);

end
