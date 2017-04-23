function [WF_log]= WeberAnalysis_Palamedes_2()

%Weber analysis-calculate weber fraction with reference numerosity of 10.
%dat file in the form:
% col 1:    number to be compared
% col 2:    answer of the subject (corr = 1; wrong = 0)

%Author: Seda Cavdaroglu
%Date: 19.09.2013
subNo = 1:1:5;
type = 1;%1= linear, 2 = log scale
A = [5,6,7,8,9,11,13,15,17,20];
B = [5,6,7,8,9,11,13,15,17,20];

if type == 1
    B = B./10;
else
    B = log10(B);
end

for i = 1:length(B)
    if B(i) < 1
        B(i) = 1/B(i);
    end
end



data_aud = zeros(length(subNo),length(B));
data_vis = zeros(length(subNo),length(B));
wf_aud = zeros(length(subNo),1);
wf_vis = zeros(length(subNo),1);
num_trials = zeros(1,length(B));

%figure(1);
figure('Color',[1 1 1]);
for s = 1:length(subNo)
    repsPerNum = [12 12 20 20 24 24 20 20 12 12];

    num_trials = num_trials+repsPerNum;
    %open the text file to read the output
    
    subj_file_vis = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/log_files/vis_subject_',num2str(subNo(s)),'.txt');
    subj_file_aud = strcat('/home/user/project2/Psychophysics/MultiSensory/auditoryDany/log_files/aud_subject_',num2str(subNo(s)),'.txt');
    
    
    fid_aud = fopen(subj_file_aud);
    A_aud = fscanf(fid_aud, '%g %g', [2 inf]);
    fclose(fid_aud);
    
    fid_vis = fopen(subj_file_vis);
    A_vis = fscanf(fid_vis, '%g %g', [2 inf]);
    fclose(fid_vis);
    
    % Transpose so that A matches
    % the orientation of the file
    A_aud = A_aud';
    A1_aud = A_aud(:,1); %first row of A = numbers used
    A2_aud = A_aud(:,2); %second row of A = responses
    
    A_vis = A_vis';
    A1_vis = A_vis(:,1); %first row of A = numbers used
    A2_vis = A_vis(:,2); %second row of A = responses
    %B = [5,6,7,8,9,11,12,14,16,20];

    

    num_corr_resp_aud = zeros(length(B),1);
    num_total_resp_aud = zeros(length(B),1);
    num_corr_resp_vis = zeros(length(B),1);
    num_total_resp_vis = zeros(length(B),1);
    
    for i = 1:length(A1_aud)
        indx = find(A1_aud(i) == A);
        if A2_aud(i) == 1
            num_corr_resp_aud(indx) = num_corr_resp_aud(indx) + 1;
        end;
        num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
    end;
    
    
    for i = 1:length(A1_vis)
        indx = find(A1_vis(i) == A);
        if A2_vis(i) == 1
            num_corr_resp_vis(indx) = num_corr_resp_vis(indx) + 1;
        end;
        num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
    end;
    
    
    data_vis(s,:) = num_corr_resp_vis; %number of greater than 10 responses per number in array B
    data_aud(s,:) = num_corr_resp_aud; %number of greater than 10 responses per number in array B
    

    % arrange plot
    %figure(1);
    set(gcf,'NextPlot','add');
    
    subplot(4,4,s);

    set(gca,'FontSize',8);
    if type == 1
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[5 10 15 20]);
        set(gca,'XTickLabel',{ '5' '10' '15' '20'});
    else
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
        set(gca,'XTickLabel',{'5' '10' '15' '20'});
    end;
    
    
    
    
    %Palamedes function
    if type == 1
        StimLevels = B;
        paramsValues = [1.1 0.68 0.5 0];
        maxStimLevels = max(B);
    else
        StimLevels =B;
        paramsValues = [1.1 0.68 0.5 0];
        maxStimLevels = max(B);
    end;
    NumPos = num_corr_resp_vis';
    OutOfNum = repsPerNum;
    PF = @PAL_CumulativeNormal;

    paramsFree = [1 1 0 0];
    [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues,paramsFree,PF);
    wf_vis(s,1) = paramsValues(1);
    disp(strcat('Weber Fraction in log scale for vision for subject',num2str(subNo(s))));
    disp(wf_vis(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = min(B);

    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
%     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
%         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues,StimLevelsFine);

    
    marker = 'db';
    plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',6);    
    hold on;    
    plot(StimLevelsFine,Fit,'b','LineWidth',3);
    
    set(gca,'FontSize',8);
    if type == 1
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[5 10 15 20]);
        set(gca,'XTickLabel',{ '5' '10' '15' '20'});
    else
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
        set(gca,'XTickLabel',{'5' '10' '15' '20'});
    end;
    
    
    xlabel('Numbers');
    ylabel('Portion of corr Responses');
    
    % arrange plot
    hold on;
    
    
    %Palamedes function
    if type == 1
        StimLevels = B;
        paramsValues = [1.1 0.68 0.5 0];
        maxStimLevels = max(B);
    else
        StimLevels =B;
        paramsValues = [1.1 0.68 0.5 0];
        maxStimLevels = max(B);
    end;

    NumPos = num_corr_resp_aud';
    OutOfNum = repsPerNum;
    PF = @PAL_CumulativeNormal;
    paramsFree = [1 1 0 0];
    [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues,paramsFree,PF);
    wf_aud(s,1) = paramsValues(1);
    disp(strcat('Weber Fraction in log scale for audition for subject',num2str(subNo(s))));
    disp(wf_aud(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = min(B);
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
%     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
%         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues,StimLevelsFine);
    marker = 'dr';
    plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',6);
    
    hold on;
    
    plot(StimLevelsFine,Fit,'r','LineWidth',3);
    
    set(gca,'FontSize',8);
    if type == 1
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[5 10 15 20]);
        set(gca,'XTickLabel',{ '5' '10' '15' '20'});
    else
        axis([min(B) max(B) 0.3 1]);
        set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
        set(gca,'XTickLabel',{'5' '10' '15' '20'});
    end;

    title(strcat('Subject ',num2str(subNo(s))));
    
    if s == length(subNo)
        
        %get mean responses for vision
        num_corr_resp_vis = sum(data_vis(:,1:10));
        num_corr_resp_aud = sum(data_aud(:,1:10));
        
        % arrange plot
        subplot(4,4,s+1);
        set(gca,'FontSize',8);
        if type == 1
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[5 10 15 20]);
            set(gca,'XTickLabel',{ '5' '10' '15' '20'});
        else
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
            set(gca,'XTickLabel',{'5' '10' '15' '20'});
        end;
        
        
        
        %Palamedes function
        if type == 1
            StimLevels = B;
            paramsValues = [1.1 0.68 0.5 0];
            maxStimLevels = max(B);
        else
            StimLevels =B;
            paramsValues = [1.1 0.68 0.5 0];
            maxStimLevels = max(B);
        end;
        NumPos = num_corr_resp_vis;
        OutOfNum = num_trials;
        PF = @PAL_CumulativeNormal;

        paramsFree = [1 1 0 0];
        [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues,paramsFree,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = min(B);

        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
%         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
%             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'db';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',6);
        
        hold on;
        
        plot(StimLevelsFine,Fit,'b','LineWidth',3);
        
        set(gca,'FontSize',8);
        if type == 1
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[5 10 15 20]);
            set(gca,'XTickLabel',{ '5' '10' '15' '20'});
        else
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
            set(gca,'XTickLabel',{'5' '10' '15' '20'});
        end;
    
        xlabel('Numbers');
        ylabel('Portion of corr Responses');
        
        
        % arrange plot
        hold on;
        
        %Palamedes function
        if type == 1
            StimLevels = B;
            paramsValues = [1.1 0.68 0.5 0];
            maxStimLevels = max(B);
        else
            StimLevels =B;
            paramsValues = [1.1 0.68 0.5 0];
            maxStimLevels = max(B);
        end;
        NumPos = num_corr_resp_aud;
        OutOfNum = num_trials;
        PF = @PAL_CumulativeNormal;

        paramsFree = [1 1 0 0];
        [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues,paramsFree,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = min(B);

        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
%         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
%             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'dr';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',6);
        hold on;
        
        plot(StimLevelsFine,Fit,'r','LineWidth',3);
        
        set(gca,'FontSize',8);
        if type == 1
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[5 10 15 20]);
            set(gca,'XTickLabel',{ '5' '10' '15' '20'});
        else
            axis([min(B) max(B) 0.3 1]);
            set(gca,'XTick',[log(5) log(10) log(15) log(20)]);
            set(gca,'XTickLabel',{'5' '10' '15' '20'});
        end;

        
        
        title('Mean data over all subjects');
        legend('Visual Data','Visual Fit','Auditory Data','Auditory Fit');
        
        [H,P,CI,STATS] = ttest(wf_vis,wf_aud);
        disp('Results of ttest between WF for vision and audition:');
        disp(P);
        disp(STATS);
        
        disp('Mean WF visual:');
        disp(mean(wf_vis));
        
        
        disp('Mean WF auditory:');
        disp(mean(wf_aud));
    end;
end

%[H,P,CI,STATS] = ttest(R2_lin,R2_log); % to test whether log scale fits better than lin scale
