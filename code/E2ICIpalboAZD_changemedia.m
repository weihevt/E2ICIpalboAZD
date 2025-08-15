function changemedia = E2ICIpalboAZD_changemedia(tspan)
% Change of media: In the experiment, the media is replaced every 3–4 days.  
% Since this work doesn't involve E2 deprivation treatment and pharmacokinetics are not  
% modeled so the drug concentration is assumed to remain constant,
% the media change does not affect the outcome. 
% t unit: hours
changemedia1 = 3:7:tspan(end)/24;
changemedia2 = 7:7:tspan(end)/24;
changemedia = sort([changemedia1,changemedia2]);
changemedia = changemedia(changemedia*24 > tspan(1));
end