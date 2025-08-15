function E2ICIpalboAZD_minimumAZD_2treat()
% This function generates the treatment options shown in Fig.7A-C. It
% includes only two options: E2(10nM)+palbo(750nM) and
% E2(10nM)+ICI(750nM)+AZD(250nM). Over a two-year period,there are 2^23
% possible combinations. The goal is to keep the maximum proliferation
% below 20. I explored all possibilities in which at least 5 periods of
% E2(10nM)+ICI(750nM)+AZD(250nM) are included, as attempts with fewer than 
% 5 such periods did not maintain proliferation below the threshold.
% 0: E2(10nM)+palbo(750nM) treatment.
% 1: E2(10nM)+ICI(750nM)+AZD(250nM) treatment.

filename = './mat/Lop_2treat.mat';
args = E2ICIpalboAZD_modelpar();

Num_days = 28;
Num_hours = 24;
cellnum_thres = 20;
if ~isfile(filename)
    Num_treat = 23;
    
    L = cell(1,Num_treat);
    L(:) = {[0,1]};
    n = length(L);
    [L{:}] = ndgrid(L{end:-1:1});
    L = cat(n+1,L{:});
    L = fliplr(reshape(L,[],n));

    sumL = sum(L,2);
    pos = sumL == 5;
    L = L(pos,:);

    cellnum = ones(1,size(L,1));
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
    treat_ICI750nM_AZD250nM = args.treat_ICI750nM_AZD250nM;
    for i = 1:size(L,1)
        disp((i)/size(L,1))
        i_L = L(i,:);
        i_treatalter = cell(1,Num_month);
        i_treatalter{1}.treat = treat_palbo750nM;
        i_treatalter{1}.duration = daypermonth;
        for j = 2:Num_month
            if i_L(j-1) == 0
                i_treatalter{j}.treat = treat_palbo750nM;
            elseif i_L(j-1) == 1
                i_treatalter{j}.treat = treat_ICI750nM_AZD250nM;
            end
            i_treatalter{j}.duration = daypermonth;
        end

        cycletime = sum(cell2mat(cellfun(@(x) x.duration,i_treatalter,'UniformOutput',false)));
        cycletime = cycletime*Num_hours;
        [i_t,i_simAlter] = E2ICIpalboAZD_simalternation(x0,tspan,i_treatalter,cycletime,replate,args);
        pos = find(i_t==Num_month*args.daypermonth*Num_hours,1,'first');
        i_cellnum = i_simAlter(end,1:pos);
        cellnum(i) = max(i_cellnum);
    end
    disp(min(cellnum))
    pos = find(cellnum <= cellnum_thres);
    if numel(pos) ~= 0
        cellnum_ = cellnum(pos);
        L_ = L(pos,:);
        AZDdose = sum(L_,2);
        pos = find(AZDdose == min(AZDdose));
        L_ = L_(pos,:);
        [L_,ia,~] = unique(L_,'rows');
        pos = pos(ia);
        pos = find(cellnum_(pos) == min(cellnum_(pos)));
        L_ = L_(pos(1),:);
        Lop_2treat = L_;
        save(filename,'Lop_2treat')
    end
else
    Numparset = 100;
    Num_month = 24;
    L_ = load(filename);
    L_ = L_.Lop_2treat;
    tspan = [0,Num_month*Num_days*Num_hours];
    cellnumAlter = zeros(Num_month*Num_days*Num_hours+1,Numparset);
    cdk6 = zeros(Num_month*Num_days*Num_hours+1, Numparset);
    cyclinE1 = zeros(Num_month*Num_days*Num_hours+1, Numparset);

    opmat = load('opmat.mat');
    par_cohort = opmat.populationT';
    par_cohort = par_cohort(:,1:Numparset);
    args_ = E2ICIpalboAZD_modelpar();
    par_cohort(:,1) = args_.PAR;
    for i = 1:size(par_cohort,2)
        disp(i/100)
        i_args = args_;
        i_args.PAR = par_cohort(:,i);
        % initial value of variables
        i_x0 = zeros(i_args.Numvariable,1);
        i_x0(i_args.E2mediaindex) = i_args.ValE2normal;
        i_x0 = E2ICIpalboAZD_replating(i_x0,i_args);

        [~,~,i_xinitial] = E2ICIpalboAZD_sim(i_x0,tspan,i_args.treat_non,i_args);

        % set the steady state
        i_x0 = i_xinitial(end,:);
        i_x0(i_args.ind_reset) = 0;
        i_x0 = E2ICIpalboAZD_replating(i_x0,i_args);

        replate = true;
        i_x0(i_args.E2mediaindex) = i_xinitial(i_args.E2mediaindex);

        % Alternating: E2(10nM)+palbo(750nM) -> E2(10nM)+ICI(750nM)+AZD(250nM)
        i_treatalter = cell(1,Num_month);
        i_treatalter{1}.treat = i_args.treat_palbo750nM;
        i_treatalter{1}.duration = i_args.daypermonth;

        for j = 2:Num_month
            if L_(j-1) == 0
                i_treatalter{j}.treat = i_args.treat_palbo750nM;
            elseif L_(j-1) == 1
                i_treatalter{j}.treat = i_args.treat_ICI750nM_AZD250nM;
            end
            i_treatalter{j}.duration = i_args.daypermonth;
        end

        cycletime = sum(cell2mat(cellfun(@(x) x.duration,i_treatalter,'UniformOutput',false)));
        cycletime = cycletime*Num_hours;
        [i_t,i_simAlter,i_x] = E2ICIpalboAZD_simalternation(i_x0,tspan,i_treatalter,...
                                                            cycletime,replate,i_args);

        pos = find(i_t==Num_month*i_args.daypermonth*Num_hours,1,'first');
        i_t = i_t(1:pos);
        i_cellnum = i_simAlter(end,1:pos);
        i_cdk6 = sum(i_x(:,i_args.ind_containcdk6),2);
        i_cdk6 = i_cdk6./i_cdk6(1);
        i_cdk6 = i_cdk6(1:pos);

        i_cyclinE1 = sum(i_x(:,i_args.ind_containcyclinE1),2);
        i_cyclinE1 = i_cyclinE1./i_cyclinE1(1);
        i_cyclinE1 = i_cyclinE1(1:pos);

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

    writematrix(cellnumAlter_,'cellnumAlter_minAZD_2treat.xls')
    writematrix(cdk6_,'cdk6_minAZD_2treat.xls')
    writematrix(cyclinE1_,'cyclinE1_minAZD_2treat.xls')
    writematrix(L_,'treat_minAZD_2treat.xls')
end
end