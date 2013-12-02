function nAttrs = getNAttrs(X)
% Returns the dimensionality of the data in the cells X.
   for i=1:length(X)
      if ~isempty(X{i})
         nAttrs=size(X{i},1);
         return;
      end
   end
end