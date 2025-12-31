function [state,options,optchanged] = E2ICIpalboAZD_11_gaoutput(options,state,~,costthreshold)
% This function is output function in the GA algorithm saves the parameter cohort to ./code/mat/opmat.mat.

format compact
filename = './mat/opmat.mat';
optchanged = [];
scores = state.Score;
population = state.Population;

ind = find(scores <= costthreshold);

if isempty(ind)
    sprintf('%0.0f, %0.1f, %0.2f',[state.Generation,nan,min(scores)])
    return;
end

[PAR,~,~,~,groupparall,~] = E2ICIpalboAZD_04_par();
PARpopulation = repmat(PAR',numel(ind),1);
PARpopulation(:,groupparall) = population(ind,:);
scores = scores(ind);

if exist(filename,'file')
    opmat = load(filename);
    populationT = opmat.populationT;
    scoresT = opmat.scoresT;
    populationT = [populationT;PARpopulation];
    scoresT = [scoresT;scores];
else
    populationT = PARpopulation;
    scoresT = scores;
end

[C,ia] = unique(populationT,'rows');
populationT = C;
scoresT = scoresT(ia);
if size(populationT,1) > 1
    diffnum = sum(any(diff(sort(populationT)),1)); % number of parameters with different value
else
    diffnum = nan;
end

if ~isempty(scores)
    minScore = min(scores);
else
    minScore = nan;
end

if size(populationT,1) > 3
    meanPAR = mean(populationT(:,groupparall));
    varPAR = var(populationT(:,groupparall));
    CoeffVar = sqrt(varPAR)./meanPAR * 100;
    CoeffVar = -log(CoeffVar);
else
    CoeffVar = nan;
end

sprintf('%0.0f, %0.0f, %0.2f, %0.0f, %0.2f',...
        [state.Generation,numel(scoresT),minScore,diffnum,max(CoeffVar)])
save(filename,'populationT','scoresT')
end