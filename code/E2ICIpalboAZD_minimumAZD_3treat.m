function E2ICIpalboAZD_minimumAZD_3treat()
% This function generates the treatment options shown in Fig.7E-F. It
% includes only three options: E2(10nM)+palbo(750nM), E2(10nM)+ICI(750nM) and
% E2(10nM)+ICI(750nM)+AZD(250nM). Over a two-year period, the goal is to keep the maximum 
% proliferation below 20.
% I provide an initial treatment plan for the optimization, L_init
% You can try running it without providing an initial treatment, 
% and then use the results from that run to choose an initial treatment afterward.
% Meaning of the value in L:
% 0: E2(10nM)+palbo(750nM) treatment.
% 1: E2(10nM)+ICI(750nM) treatment.
% 2: E2(10nM)+ICI(750nM)+AZD(250nM) treatment.

% File saves the final treatment selections.
filename = './mat/Lop_3treat.mat';
% File stores the treatment selections that meet the requirements during the optimization.
filename_L = './mat/L_3treat.mat';
args = E2ICIpalboAZD_modelpar();
% Based on the initial treatment plan explored, a maximum of 6 periods of 
% E2(10nM)+ICI(750nM)+AZD(250nM) should be effective.

Num_days = 28;
Num_hours = 24; 
Num_AZD = 6;
flag_op = true;
if ~isfile(filename) || flag_op
    Num_month = 23;
    cellnum_thres = 20;
    L_init = [0,0,1,0,0,2,0,1,2,0,0,2,0,0,2,0,0,2,1,0,2,0,0
              0,2,0,1,0,2,1,1,1,1,2,0,2,1,1,1,1,2,1,1,2,1,1];

    nVar = Num_month;
    lb = zeros(1,nVar);
    ub = 2*ones(1,nVar);
    optcon = optimoptions('ga','FunctionTolerance',0.5,...
                          'InitialPopulationMatrix',L_init,...
                          'UseParallel',false);
    [L,fval,exitflag] = ga(@child_dose,nVar,[],[],[],[],lb,ub,...
                           @(x)child_con(x,args,cellnum_thres,filename_L,Num_AZD,Num_days,Num_hours),...
                           1:nVar,optcon);
    cellnum = child_sim(L,args,Num_days,Num_hours);
    fprintf('exitflag:%d, AZD:%d, maxcellnum:.%3f\n',exitflag,fval,max(cellnum))
    disp(L)
    if max(cellnum) <= cellnum_thres
        Lop_3treat = L;
        save(filename,'Lop_3treat')
    end
else
    Num_month = 24;   
    Numparset = 100;
    L_ = load(filename);
    L_ = L_.Lop_3treat;
    cellnumAlter = zeros(Num_month*Num_days*Num_hours+1,Numparset);
    cdk6 = zeros(Num_days*Num_hours*(Num_month)+1,Numparset);
    cyclinE1 = zeros(Num_days*Num_hours*(Num_month)+1,Numparset);

    opmat = load('opmat.mat');
    par_cohort = opmat.populationT';
    par_cohort = par_cohort(:,1:Numparset);
    args_ = E2depICIpalbo_modelpar();
    par_cohort(:,1) = args_.PAR;
    for i = 1:size(par_cohort,2)
        disp(i/100)
        i_args = args_;
        i_args.PAR = par_cohort(:,i);

        [i_cellnum,i_t,i_x] = child_sim(L_,i_args);

        i_cdk6 = sum(i_x(:,i_args.ind_containcdk6),2);
        i_cdk6 = i_cdk6./i_cdk6(1);

        i_cyclinE1 = sum(i_x(:,i_args.ind_containcyclinE1),2);
        i_cyclinE1 = i_cyclinE1./i_cyclinE1(1);

        [C,ia] = unique(i_t);
        assert(all(diff(C) == 1))
        i_cellnum = i_cellnum(ia);
        i_cdk6 = i_cdk6(ia);
        i_cyclinE1 = i_cyclinE1(ia);
        i_t = i_t(ia);

        cellnumAlter(:,i) = i_cellnum;
        cdk6(:,i) = i_cdk6;
        cyclinE1(:,i) = i_cyclinE1;
    end

    cellnumAlter_min = min(cellnumAlter,[],2);
    cellnumAlter_max = max(cellnumAlter,[],2);
    cellnumAlter = [i_t,cellnumAlter_min,cellnumAlter_max];

    cdk6_min = min(cdk6,[],2);
    cdk6_max = max(cdk6,[],2);
    cdk6 = [i_t,cdk6_min,cdk6_max];

    cyclinE1_min = min(cyclinE1,[],2);
    cyclinE1_max = max(cyclinE1,[],2);
    cyclinE1 = [i_t,cyclinE1_min,cyclinE1_max];
    
    cellnumAlter_ = zeros(Num_hours*args.daypermonth+2,Num_month*2);
    cdk6_ = zeros(Num_hours*args.daypermonth+2,Num_month*2);
    cyclinE1_ = zeros(Num_hours*args.daypermonth+2,Num_month*2);
    for i = 1:Num_month
        t_sel = (i-1)*Num_hours*args.daypermonth:i*Num_hours*args.daypermonth;
        pos = ismember(i_t,t_sel);
        i_cellnumAlter = cellnumAlter(pos,2:3);
        i_cdk6 = cdk6(pos,2:3);
        i_cyclinE1 = cyclinE1(pos,2:3);

        i_cellnumAlter(1,:) = [1,1];
        i_cellnumAlter = [i,i;i_cellnumAlter];
        i_cdk6 = [i,i;i_cdk6];
        i_cyclinE1 = [i,i;i_cyclinE1];
        cellnumAlter_(:,[1,2]+(i-1)*2) = i_cellnumAlter;
        cdk6_(:,[1,2]+(i-1)*2) = i_cdk6;
        cyclinE1_(:,[1,2]+(i-1)*2) = i_cyclinE1;
    end

    writematrix(cellnumAlter_,'cellnumAlter_minAZD_3treat.xls')
    writematrix(cdk6_,'cdk6_minAZD_3treat.xls')
    writematrix(cyclinE1_,'cyclinE1_minAZD_3treat.xls')
    writematrix(L_,'treat_minAZD_3treat.xls')
end

end

function AZDdose = child_dose(x)
AZDdose = sum(x==2);
end

function [c, ceq] = child_con(L,args,cellnum_thres,filename,Num_AZD,Num_days,Num_hours)
    cellnum = child_sim(L,args,Num_days,Num_hours);
    c = max(cellnum)-cellnum_thres;
    if c <= 0
        if exist(filename,'file')
            L_ = load(filename).L;
            if sum(L == 2) <= max(sum(L_ == 2, 2))
                L = [L_;L];
                L = unique(L,'rows');
                save(filename,'L')
                fprintf('AZD:%d, maxcellnum: %.3f\n',min(sum(L==2,2)),max(cellnum))
            end
        else
            if sum(L == 2) <= Num_AZD
                save(filename,'L')
            end
        end
    end
    ceq = [];
end

function [cellnum,t,x] = child_sim(L,args,Num_days,Num_hours)
    Num_month = 24;
    tspan = [0,Num_month*Num_days*Num_hours];
    x0 = zeros(args.Numvariable,1);
    x0(args.E2mediaindex) = args.ValE2normal;
    x0 = E2ICIpalboAZD_replating(x0,args);
    [~,~,xinitial] = E2ICIpalboAZD_sim(x0,tspan,args.treat_non,args);

    % set the steady state
    x0 = xinitial(end,:);
    x0(args.ind_reset) = 0;
    x0 = E2ICIpalboAZD_replating(x0,args);

    replate = true;
    tspan = [0,Num_month*Num_days*Num_hours];
    x0(args.E2mediaindex) = xinitial(args.E2mediaindex);
    treat_palbo750nM = args.treat_palbo750nM;
    daypermonth = args.daypermonth;

    treatalter = cell(1,Num_month);
    treatalter{1}.treat = treat_palbo750nM;
    treatalter{1}.duration = daypermonth;
    for i = 2:Num_month
        if L(i-1) == 0
            treatalter{i}.treat = args.treat_palbo750nM;
        elseif L(i-1) == 1
            treatalter{i}.treat = args.treat_ICI750nM;
        elseif L(i-1) == 2
            treatalter{i}.treat = args.treat_ICI750nM_AZD250nM;
        else
            treatalter{i}.treat = nan;
        end
        treatalter{i}.duration = daypermonth;
    end

    cycletime = sum(cell2mat(cellfun(@(x) x.duration,treatalter,'UniformOutput',false)));
    cycletime = cycletime*Num_hours;
    [t,simAlter,x] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args);
    pos = find(t==Num_month*args.daypermonth*Num_hours,1,'first');
    cellnum = simAlter(end,1:pos);
    t = t(1:pos);
    x = x(1:pos,:);
end