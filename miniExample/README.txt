In this synthetic example there are three main pieces of code:

MLMTL_ConvexL2BallRadiusMTL.m (in ../TotanaImpl, the place where the methods are stored): It contains a class responsible for the execution of the method described in the paper. The implementation itself is in the file MLMTL_ConvexL2Ball_radius. See comments in the latter file for more information.
makeData: It generates a synthetic dataset, using the parameters specified in the structure DataParameters (such as dimensions of the tensor, rank...). See comments inside the file for more information.
	  The resultant tensors are stored in the struct dataConf. The implementation of the method expects a Multilinear multitask learning dataset (previous point). This conversion is conversion is made in completion2MTL.m. 
Main.m:   It contains the specifications of the experiment.