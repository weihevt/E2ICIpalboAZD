function mutationChildren = E2ICIpalboAZD_mutation(parents,options,GenomeLength,~,state,...
                                                   ~,thisPopulation,varargin)
%% (17) Function index in the GitHub repository
% This self-modifying function is used as the mutation function within the genetic algorithm (ga).

% MUTATIONADAPTFEASIBLE Mutation operator for linearly constrained
% optimization problems.
% MUTATIONCHILDREN = MUTATIONADAPTFEASIBLE(PARENTS,OPTIONS,GENOMELENGTH,...
% FITNESSFCN,STATE,THISSCORE,THISPOPULATION) Creates the mutated children
% using adaptive mutation. Mutated genes satisfy linear constraints.
% Example:
% options = optimoptions('ga','MutationFcn',{@mutationadaptfeasible});
% (Note: If calling gamultiobj, replace 'ga' with 'gamultiobj')
% This specifies that the mutation function used will be
% MUTATIONADAPTFEASIBLE
% Copyright 2005-2015 The MathWorks, Inc.


persistent StepSize lb ub
% Binary strings always maintain feasibility

filename = './mat/opmat.mat';
if state.Generation <= 2
    StepSize = 1; % Initialization
    mlock % protect the persistent variable until we start
else
    if isfield(state,'Spread')
        if state.Spread(end) > state.Spread(end-1)
            StepSize = min(1,StepSize*4);
        else
            StepSize = max(sqrt(eps),StepSize/4);
        end
    else
        if state.Best(end) < state.Best(end-1)
            StepSize = min(1,StepSize*4);
        else
            StepSize = max(sqrt(eps),StepSize/4);
        end
    end
end

scale = 1; % Using no scale

% Extract information about constraints
tol = max(sqrt(eps),options.TolCon);
if state.Generation <= 2
    [~,lb,ub,~,~,~] = E2ICIpalboAZD_par();
    lb = lb(varargin{2});
    ub = ub(varargin{2});
end

if exist(filename,'file')
    opmat = load(filename);
    populationT = opmat.populationT;
    % this nochangeind says don't change the lower and upper bound of these parameters
    nochangeind = varargin{5}.ind;
    [~,pos] = ismember(nochangeind,varargin{2});
    if size(populationT,1) > varargin{1} && min(state.Score) <= varargin{4}
        population = populationT(:,varargin{2});
        meanPAR = mean(population);
        varPAR = var(population);
        Percentage = sqrt(varPAR)./meanPAR*100;
        Percentage = -log(Percentage);
        Percentage = Percentage - min(Percentage) + 1;
        PARmax = max(population);PARmax = PARmax(:);
        PARmin = min(population);PARmin = PARmin(:);
        ratiolb = (PARmin - lb)./lb;
        ind = find(ratiolb <= 1e-3);
        for i = 1:length(ind)
            i_ind = ind(i);
            [flagin,pos_ind] = ismember(i_ind,pos);
            if ~flagin
                lb(i_ind) = 0.95 * lb(i_ind);
            elseif lb(i_ind) > 1/0.95*varargin{5}.lb(pos_ind)
                lb(i_ind) = 0.95 * lb(i_ind);
            end
        end
        ratioub = (ub - PARmax)./ub;
        ind = find(ratioub <= 1e-3);
        for i = 1:length(ind)
            i_ind = ind(i);
            [flagin,pos_ind] = ismember(i_ind,pos);
            if ~flagin
                ub(i_ind) = 1/0.95*ub(i_ind);
            elseif ub(i_ind) < 0.95*varargin{5}.ub(pos_ind)
                ub(i_ind) = 1/0.95*ub(i_ind);
            end
        end
    else
        Percentage = [];
    end
else
    Percentage = [];
end
% Initialize childrens
mutationChildren = zeros(length(parents),GenomeLength);
% Create childrens for each parents
for i = 1:length(parents)
    x = thisPopulation(parents(i),:)';
    % Get the directons which forms the positive basis(minimal or maximal basis)
    [Basis,TangentCone] = child_boxdirections(true,StepSize,x,lb,ub,tol); % no changes of this function,as ga default
    % If the point is on the constraint boundary (nonempty TangentCone)
    % we use scale = 1
    if ~isempty(TangentCone)
        scale = 1;
        TangentCone(:,(~any(TangentCone))) = [];
    end
    nDirTan = size(TangentCone,2);
    nBasis = size(Basis,2);
    % Add tangent cone to the direction vectors
    DirVector = [Basis TangentCone];
    % Total number of search directions
    nDirTotal = nDirTan + nBasis;
    % Make the index vector to be used to access directions
    indexVec = [1:nBasis 1:nBasis (nBasis+1):nDirTotal (nBasis+1):nDirTotal];
    % Vector to take care of sign of directions
    dirSign = [ones(1,nBasis) -ones(1,nBasis) ones(1,nDirTan) -ones(1,nDirTan)];
    OrderVec = randperm(length(indexVec));
    % Total number of trial points
    numberOfXtrials = length(OrderVec);
    % Check of empty trial points
    if (numberOfXtrials ~= 0)
        for k = 1 : numberOfXtrials
            direction = dirSign(k) .* DirVector(:,indexVec(OrderVec(k)));
            if ~isempty(Percentage)
                [~,maxpos] = max(Percentage);
                % Randomly sample parameters, the weights are their Percentage =  -log(var/mean).
                % The lower the Percentage, the higher opportunity to be selected.
                directionadd = datasample(1:numel(Percentage),varargin{3},'Replace',false,'weight',Percentage);
                if ~ismember(maxpos,directionadd)
                    directionaddnew = [directionadd,maxpos];
                else
                    directionaddnew = directionadd;
                end
                directionadd = directionaddnew;
                directionaddrange = zeros(numel(directionadd),1);
                for j = 1 : numel(directionadd)
                    ranval = .5 * rand * (ub(directionadd(j)) - lb(directionadd(j)))/(StepSize * scale);
                    directionaddrange(j) = max(ranval,1);
                end
                direction(directionadd) = sign(rand(numel(directionadd),1) - 0.5).* directionaddrange;
            end
            mutant = x + StepSize * scale .* direction;
            mutantun = mutant;
            for j = 1 : numel(mutant)
                if mutant(j) <= lb(j)
                    mutantun(j) = -pi/2; % infeasible starting value
                elseif mutant(j) >= ub(j)
                    mutantun(j) = pi/2;
                else
                    mutantun(j) = 2 * (mutant(j) - lb(j))/(ub(j) - lb(j)) - 1;
                    mutantun(j) = asin(max(-1, min(1, mutantun(j))));
                end
            end
            mutant = child_xtransform(mutantun,ub,lb);
            mutationChildren(i,:) = mutant';
        end
    else
        mutationChildren(i,:) = x';
    end
end
end

function xtrans = child_xtransform(x,ub,lb)
% converts unconstrained into their original domains
xtrans = x;
for i = 1:length(x)
    xtrans(i) = (sin(x(i)) + 1)/2; % lower and upper bounds
    xtrans(i) = xtrans(i) * (ub(i) - lb(i)) +lb(i);
end
end

function [Basis,TangentCone,AugmentedDirs] = child_boxdirections(AdaptiveMesh,MeshSize,x,lb,ub,tol)
% BOXDIRECTIONS finds search vectors when bound constraints are present.
% AdaptiveMesh is a boolean value which is true if MADS is used to poll
% and X is the current point. Input arguments 'lb' and 'ub' are lower 
% and upper bounds respectively and 'tol' is the binding tolerance used
% to determine whether bounds are active or not.

% Copyright 2003-2017 The MathWorks, Inc.

AugmentedDirs = [];
vars = length(x);
I = eye(vars);
% Check which bounds are active for lb <= x <= ub at 'x'
active = abs(x - lb) <=tol | abs(x - ub) <=tol;
% Include all directions parallel to active bounds
TangentCone = I(:,active);

% N linearly independent vectors 
if ~AdaptiveMesh
    Basis = I(:,~active);
else
    pollParam = 1/sqrt(MeshSize);
    lowerT = tril((round((pollParam+1)*rand(vars)-0.5)),-1);
    diagtemp = pollParam*sign(rand(vars,1)-0.5);
    diagtemp(~diagtemp) = pollParam*sign(0.5-rand);
    diagT  = diag(diagtemp);
    Basis = lowerT + diagT;
    order = randperm(vars);
    Basis = Basis(order,order);
end
end