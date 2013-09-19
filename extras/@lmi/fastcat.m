function X = fastcat(varargin)

X = varargin{1};
nTOT = length(X.clauses);
for i = 2:nargin
    X.clauses = cat(2,X.clauses,varargin{i}.clauses);   
    nTOT = nTOT + length(varargin{i}.clauses);
    X.LMIid = [X.LMIid varargin{i}.LMIid];
end

% VERY FAST UNIQUE BECAUSE THIS IS CALLED A LOT OF TIMES....
i = sort(X.LMIid);
i = i(diff([i NaN])~=0);
if length(i)<nTOT
    [i,j] = unique(X.LMIid);
    X = subsref(X,struct('type','()','subs',{{j}}));
end