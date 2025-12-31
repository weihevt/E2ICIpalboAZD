function E2ICIpalboAZD_24_genparcohort()
% This function generates ./code/mat/opmat.mat, the first step is to create the parameter cohort.

expand = true;
filepath_opmat = './mat/opmat.mat';
% If filepath_opmat already exists and has parameters, continue expanding
% the parameter cohort and later select a subset.
% The while loop does not exit automatically, manually end it with Ctrl-C.

if ~expand
    % Generate the parameter cohort, starting with one PAR.
    % Begin from here.

    warning('off','all')
    args = E2ICIpalboAZD_05_modelpar();
    PAR = args.PAR;
    lbuse = args.lb(args.groupparall);
    ubuse = args.ub(args.groupparall);
    PAR0 = PAR(args.groupparall);
    
    % Check if any parameter values are below the lower bound or above the upper bound.
    ind = args.groupparall(((PAR0 - lbuse) < 0));
    val = PAR0(((PAR0 - lbuse) < 0));
    PAR_smaller_than_lb = [ind,val];
    ind = args.groupparall((PAR0 - ubuse) > 0);
    val = PAR0(((PAR0 - ubuse) > 0));
    PAR_bigger_than_ub = [ind,val];
    if ~isempty(PAR_smaller_than_lb) || ~isempty(PAR_bigger_than_ub)
        error('lb or ub problem')
    end

    InitialPMuse = PAR0';
    limit_par.ind = args.power_ind(:,1);
    limit_par.lb = args.power_ind(:,2);
    limit_par.ub = args.power_ind(:,3);
    opt = true; % If set to false, only the cost value will be calculated.

    PopulationSize = 250; % Specifies the number of individuals per generation in the GA algorithm.
    Generations = 2e3; % Specifies the maximum number of iterations for the GA to perform.
    numsize = 20; % Once populationT contains 20 members, compute its variance.
    costthreshold = 750; % Cost value threshold; values below this will be retained in the parameter cohort.
    numdirecadd = 2; % number of direction add to exploriation
    numMaxEliteCount = 10; % maxnumber of elite count

    while 1 > 0
        i_iter = 1;
        x0 = PAR(args.groupparall);
        E2ICIpalboAZD_25_findcohort(x0,args,lbuse,ubuse,args.groupparall,limit_par,opt,InitialPMuse,...
                                 PopulationSize,Generations,costthreshold,numsize,...
                                 numdirecadd,numMaxEliteCount);
        i_iter = i_iter + 1;
        disp(i_iter)
    end
end
%%
% If filepath_opmat already exists and has parameters,
% continue expanding the parameter cohort and later select a subset.
% The while loop does not exit automatically, manually end it with Ctrl-C.

costthreshold = 700; % Cost value threshold; values below this will be retained in the parameter cohort
if expand
    ratio = 0.95;
    InitialPopulationMatrix = load(filepath_opmat);

    ind = InitialPopulationMatrix.scoresT < costthreshold;
    populationT = InitialPopulationMatrix.populationT(ind,:);

    PARmax = max(populationT,[],1);
    PARmin = min(populationT,[],1);

    args = E2ICIpalboAZD_05_modelpar();
    PAR = args.PAR;

    lbuse = args.lb(args.groupparall);
    ubuse = args.ub(args.groupparall);

    PARmax = PARmax(args.groupparall)';
    PARmin = PARmin(args.groupparall)';
    PARop = PAR(args.groupparall);

    limit_par.ind = args.power_ind(:,1);
    limit_par.lb = args.power_ind(:,2);
    limit_par.ub = args.power_ind(:,3);
    opt = true;

    ind = sort([find((PARmin - lbuse)./lbuse < 0.05);find((ubuse - PARmax)./PARmax < 0.05)]);
    ind_delete = [];
    for i = 1:numel(ind)
        i_indori = args.groupparall(ind(i));
        if ismember(i_indori,limit_par.ind) 
            [~, pos] = ismember(i_indori,limit_par.ind);
            if ubuse(i_indori) >= limit_par.ub(pos)||lbuse(i_indori) <= limit_par.lb(pos)
                ind_delete = [ind_delete, i];
            end
        end
    end
    % ind(ind_delete) = [];
    ind = unique(ind);

    parlbub = [args.groupparall,lbuse,ubuse,PARmin * ratio,PARmax * 1/ratio];

    for i = 1 : numel(ind)
        disp(['index = ',num2str(parlbub(ind(i),1)),...
              ', lbvalue = ',num2str(min([PARop(ind(i))*ratio, parlbub(ind(i),4)])),...
              ', ubvalue = ',num2str(max([PARop(ind(i))*1/ratio, parlbub(ind(i),5)]))])
    end

    while 1 > 0
        warning('off','all')
        InitialPopulationMatrix = populationT;
        InitialPopulationMatrix = InitialPopulationMatrix(:,args.groupparall);

        PopulationSize = 500; % Specifies the number of individuals per generation in the GA algorithm.
        Generations = 2e3; % Specifies the maximum number of iterations for the GA to perform.
        numsize = 20; % Once populationT contains 20 members, compute its variance.
        numdirecadd = 2; % Number of directions added to exploration.
        numMaxEliteCount = 500; % Maximum number of elite members.
    
        if size(InitialPopulationMatrix,1) > PopulationSize
            i_c = randi(size(InitialPopulationMatrix,1),PopulationSize,1);
            InitialPMuse = InitialPopulationMatrix(i_c,:);
        else
            InitialPMuse = InitialPopulationMatrix;
        end
        InitialPMuse = [PARop';InitialPMuse(2:end,:)];

        lbuse = args.lb(args.groupparall);
        ubuse = args.ub(args.groupparall);

        x0 = PARop;
        E2ICIpalboAZD_25_findcohort(x0,args,lbuse,ubuse,args.groupparall,limit_par,opt,InitialPMuse,...
                                 PopulationSize,Generations,costthreshold,numsize,...
                                 numdirecadd,numMaxEliteCount);
    end
end
end