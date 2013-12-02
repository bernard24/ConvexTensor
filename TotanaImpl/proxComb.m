function [ record bestW bestR ] = proxComb( y, beta, alpha )
% This function calculates the proximal operator of the
% conjugate of the cardinality in the \ell_2 ball of radius alpha.

[ w record ] = myProx6( y, beta ); % This first line gets an approximation
                                   % which work as a warm start. The
                                   % overall problem is convex, so the only
                                   % objective of this function is to make
                                   % the next one quicker.
                                   
[ record bestW bestR ] = proxSubGradient( y, w, beta, alpha ); %It computes
                                   % the proximal operator mentioned in the
                                   % description by means of the projected
                                   % subgradient method.
end

