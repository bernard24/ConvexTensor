function [ u l v ] = mySVD( A )
% It computes the svd of matrix A
% The following code takes advantage of the fact that A is either very fat
% or very tall so that the original svd matlab function is called with a
% much smaller matrix.

[nRows, nCols]=size(A);
if nRows>=nCols
    [u l v]=svd(A);
    return
end
AA=A*A';
if isnan(sum(sum(AA)))
    keyboard
end
[u l2 v2]=svd(AA);
l=sqrt(diag(l2));
invl2=1./l;
invl2(l<eps)=0; %% For (near) singular A, some columns of v are spurious and thus set to 0.
l=diag(l);
invl2=diag(invl2);

v=(invl2*u'*A)';
v(isnan(v))=0; 
end

