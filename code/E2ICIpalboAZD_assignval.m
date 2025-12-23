function simresult = E2ICIpalboAZD_assignval(x,args)
%% (27) Function index in the GitHub repository
% This function maps variables in the mathematical model to their corresponding counterparts.

cMyc = sum(x(:,args.ind_containcMyc),2);
cyclinD1t = sum(x(:,args.ind_containcyclinD1,:),2);
ppRb = sum(x(:,args.ind_containppRb,:),2);
Rbt = sum(x(:,args.ind_containRb1,:),2);
Nalive = sum(x(:,args.ind_containalivecell,:),2);
Ndead = sum(x(:,args.ind_containdeadcell,:),2);
N = Nalive + Ndead;

simresult = [];
simresult(1,:) = cMyc/cMyc(1);
simresult(2,:) = cyclinD1t/cyclinD1t(1);
simresult(3,:) = ppRb/ppRb(1);
simresult(4,:) = Rbt/Rbt(1);
simresult(5,:) = Ndead./N;
simresult(6,:) = Nalive/Nalive(1);
% simresult(6,:) = N/N(1);
end