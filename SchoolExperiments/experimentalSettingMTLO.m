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
dataFunction=@formatSchoolData;
data=[];

dataParameters.mPerc={0.75};
dataParameters.realAlpha={10^0};

methodParameters.alpha={10^-2.25 10^-2 10^-1.75 10^-1.5 10^-1.25 10^-1};
methodParameters.beta={10^0};
methodParameters.nIt={500};
methodParameters.threshold={10^-10};

storeName=[];
description='Multi-Task Learning';

scriptO (methods, dataFunction, data, dataParameters, methodParameters, scoreFunction, storeName, description, []);%, seed);
