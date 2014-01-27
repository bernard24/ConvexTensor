clear all
here=pwd;
cd ../TotanaImpl
addpath(pwd);
cd ../tensor_toolbox_2.5
addpath(pwd);
cd ../../Totana2
addpath(pwd);
cd (here)

pars=[];

nothing=Nothing_MTL(pars, 'Baseline');
lInfBall=MLMTL_ConvexMTL(pars, 'l_{\infty} Ball');
l2Ball=MLMTL_ConvexL2BallRadiusMTL(pars, 'l_2 Ball');
scoreFunction=RMSEC;

methods={nothing; lInfBall; l2Ball};
dataFunction=@completion2MTL;
data=[];

dataParameters.unknownPerc={0.9};
dataParameters.noise={0};
dataParameters.realAlpha={ 10^0 };

methodParameters.alpha={10^-4 10^-2 10^0} 
methodParameters.beta={10^-2 10^-1};
methodParameters.nIt={100};
methodParameters.threshold={10^-20};

storeName=[];
description='Multi-Task Learning';

scriptO (methods, dataFunction, data, dataParameters, methodParameters, scoreFunction, storeName, description, []);%,1 seed);
