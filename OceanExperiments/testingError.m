function [te te2 te3] = testingError(U, originalT, knownInputs)
nModes=length(U);
nDims=zeros(1,nModes);
for i=1:nModes
    nDims(i)=size(U{i},2);
end
nAtoms=size(U{1},1);

errors=zeros(1,prod(nDims));
counter=1;
for h=1:nDims(1)
    auxU1=U{1}(:,h);
    for i=1:nDims(2)
        auxU2=U{2}(:,i).*auxU1;
        for j=1:nDims(3)
            auxU3=U{3}(:,j).*auxU2;
            for k=1:nDims(4)
                auxU4=U{4}(:,k).*auxU3;
                errors(counter)=sum(auxU4)-originalT.data(h,i,j,k);
                counter=counter+1;
            end
        end
    end
end

te=norm(errors)/norm(originalT.data(1:end));
te2=0;
te3=0;
end