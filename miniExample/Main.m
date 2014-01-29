
addpath('../TotanaImpl');
% Tensor Toolbox should also be in the path

DataParameters.tensorDims=[20,20,20];       % Vector with the dimensions of the tensor
DataParameters.tensorRank=[15 7 3];         % Vector with the Tucker ranks of the tensor
DataParameters.FrobeniusNorm=1;             % Frobenius norm of the ground truth tensor
DataParameters.noise=10^-3;                 % The variance of the Gaussian noise added to the ground truth tensor
DataParameters.unknownPerc=0.5;             % Number of tensor inputs that are unknown.

data = completion2MTL([], DataParameters);
methodParameters.gamma=0.001;               % Parameter that ponders the importance of the regularizer. It can take any positive real value.
methodParameters.beta=0.1;                  % Parameter of ADMM (see eq. 9 in the paper). It can take any positive real value.
% methodParameters.radius=1;                % radius of the \ell_2 ball (see Sec. 3 of the paper). In principle it can take any positive real value.
                                            % If it is not specified, it is estimated using last formula in pag. 6 in the paper.
methodParameters.nIt=200;                   
methodParameters.threshold=10^-20;

l2Ball=MLMTL_ConvexL2BallRadiusMTL(methodParameters, 'l_2 Ball');
disp('Training...');
[l2Ball] =  train(l2Ball, data);
disp('Testing...');
[l2Ball, predY] = test(l2Ball, data);
