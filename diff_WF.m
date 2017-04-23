function diff_WF(subs)
%makes a ttest between auditory and visual Weber fractions
%over subjects given in the parameter subs and displays the
%p value of the ttest

%Author:Seda Cavdaroglu
%date: 20.09.2013

WF_aud = zeros(length(subs),1);
WF_vis = zeros(length(subs),1);


for i = 1:length(subs)
    [WF_log] = WeberAnalysis(i,4);
    WF_vis(i) = WF_log(1);
    WF_aud(i) = WF_log(2);
end;

disp(WF_aud);
disp(WF_vis);
bar([mean(WF_aud),mean(WF_vis)],'b');
[H,P,CI,STATS] = ttest(WF_aud,WF_vis) % to test whether WF differs significantly between vision and audition


