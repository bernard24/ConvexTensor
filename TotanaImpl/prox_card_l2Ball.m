function [ sol ] = prox_card_l2Ball( v, lambda, alpha )
% This function calculates the proximal operator of the lambda times the
% convex envelope of the cardinality in the \ell_2 ball of radius alpha.
% This step is described in Sec. 4.2, first paragraph.

if nargin<3
    alpha=1;
end
[ jos bestW ebi ] = proxComb( v/lambda, lambda^-1, alpha );

sol=v-bestW*lambda; 
end
