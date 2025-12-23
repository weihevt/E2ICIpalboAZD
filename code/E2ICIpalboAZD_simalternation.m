function [tout,simout,xout,mse_use] = E2ICIpalboAZD_simalternation(x0,tspan,treatalter,cycletime,replate,args)
%% (13) Function index in the GitHub repository
% This function simulates alternating treatments.
Num_cycle = ceil(tspan(end)/cycletime);
totaltime = cycletime * Num_cycle;
tin = tspan(1);

tout = nan(totaltime+1,1);
xout = nan(totaltime+1,args.Numvariable);

simout = nan;
mse_use = nan;
while tin < max(tspan)
    tmod = mod(tin,cycletime);
    tcout = 0;
    for i = 1 : numel(treatalter)
        if tmod >= tcout && tmod < tcout + treatalter{i}.duration * 24
            treatind = i;
        end
        tcout = tcout + treatalter{i}.duration * 24;
    end
    
    x0(args.E2mediaindex) = treatalter{treatind}.treat.E2in;
    if replate
        x0 = E2ICIpalboAZD_replating(x0,args);
    end

    treat_i = treatalter{treatind}.treat;
    
    tspan_i = [0, treatalter{treatind}.duration * 24];
    [t,~,x,mse_use] = E2ICIpalboAZD_sim(x0,tspan_i,treat_i,args);
    if ~isnan(mse_use)
        mse_use = args.mse_error;return;
    end
    
    [tout,xout] = child_assign(t+tin,x,tout,xout);
    x0 = x(end,:);
   
    tin = tin + treatalter{treatind}.duration * 24;
end
pos = find(tout == tspan(end));
if length(pos) ~= 1
    error('Should be only one timepoint');
end
tout = tout(1:pos);
xout = xout(1:pos,:);
simout = E2ICIpalboAZD_assignval(xout,args);
end

function [tout, xout] = child_assign(t,x,tout,xout)
pos = find(isnan(tout), 1, 'first');
tout(pos:pos+length(t)-1) = t;
xout(pos:pos+length(t)-1,:) = x;
end