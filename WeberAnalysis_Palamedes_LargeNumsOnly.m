function [WF_log]= WeberAnalysis_Palamedes_LargeNumsOnly()

%Weber analysis-calculate weber fraction with reference numerosity of 10.
%dat file in the form:
% col 1:    number to be compared
% col 2:    answer of the subject (corr = 1; wrong = 0)

%Author: Seda Cavdaroglu
%Date: 19.09.2013
subNo = [2,3,4,6,7,8,9,10,11,12,13,14,16,18,19];

% B = [5,6,7,8,9,11,13,15,17,20];
B = [11,13,15,17,20];
type = 2;%1= linear, 2 = log scale

data_aud = zeros(length(subNo),length(B));
data_vis = zeros(length(subNo),length(B));
data_sim = zeros(length(subNo),length(B));
wf_aud = zeros(length(subNo),1);
wf_vis = zeros(length(subNo),1);
wf_sim = zeros(length(subNo),1);



num_greater_resp_aud = zeros(length(B),length(subNo));
num_total_resp_aud = zeros(length(B),length(subNo));
num_greater_resp_vis = zeros(length(B),length(subNo));
num_total_resp_vis = zeros(length(B),length(subNo));
num_greater_resp_sim = zeros(length(B),length(subNo));
num_total_resp_sim = zeros(length(B),length(subNo));


%figure(1);
figure('Color',[1 1 1]);
for s = 1:length(subNo)
    
    %open the text file to read the output
    
    subj_file_vis = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\visualDany\log_files\vis_subject_',num2str(subNo(s)),'.txt');
    subj_file_aud = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\auditoryDany\log_files\aud_subject_',num2str(subNo(s)),'.txt');
    subj_file_sim = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\simultaneousDany\log_files\sim_subject_',num2str(subNo(s)),'.txt');
    %     subj_file_vis = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\visualDany\log_files\only mid numbers\sub',num2str(subNo(s)),'.txt');
    %     subj_file_aud = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\auditoryDany\log_files\only mid numbers\sub',num2str(subNo(s)),'.txt');
    %     subj_file_sim = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\simultaneousDany\log_files\only mid numbers\sub',num2str(subNo(s)),'.txt');
    
    
    fid_aud = fopen(subj_file_aud);
    A_aud = fscanf(fid_aud, '%g %g', [2 inf]);
    fclose(fid_aud);
    
    fid_vis = fopen(subj_file_vis);
    A_vis = fscanf(fid_vis, '%g %g', [2 inf]);
    fclose(fid_vis);
    
    fid_sim = fopen(subj_file_sim);
    A_sim = fscanf(fid_sim, '%g %g', [2 inf]);
    fclose(fid_sim);
    
    % Transpose so that A matches
    % the orientation of the file
    A_aud = A_aud';
    A1_aud = A_aud(:,1); %first row of A = numbers used
    A2_aud = A_aud(:,2); %second row of A = responses
    indexes_aud_11 = find(A1_aud==B(1));
    indexes_aud_13 = find(A1_aud==B(2));
    indexes_aud_15 = find(A1_aud==B(3));
    indexes_aud_17 = find(A1_aud==B(4));
    indexes_aud_20 = find(A1_aud==B(5));
    
    indexes_aud = [indexes_aud_11;indexes_aud_13;indexes_aud_15;indexes_aud_17;indexes_aud_20];
    numsAud = A1_aud(indexes_aud);
    ansAud = A2_aud(indexes_aud);
    
    A_vis = A_vis';
    A1_vis = A_vis(:,1); %first row of A = numbers used
    A2_vis = A_vis(:,2); %second row of A = responses
    indexes_vis_11 = find(A1_vis==B(1));
    indexes_vis_13 = find(A1_vis==B(2));
    indexes_vis_15 = find(A1_vis==B(3));
    indexes_vis_17 = find(A1_vis==B(4));
    indexes_vis_20 = find(A1_vis==B(5));
    
    indexes_vis = [indexes_vis_11;indexes_vis_13;indexes_vis_15;indexes_vis_17;indexes_vis_20];
    numsVis = A1_vis(indexes_vis);
    ansVis = A2_vis(indexes_vis);
    
    
    A_sim = A_sim';
    A1_sim = A_sim(:,1); %first row of A = numbers used
    A2_sim = A_sim(:,2); %second row of A = responses
    indexes_sim_11 = find(A1_sim==B(1));
    indexes_sim_13 = find(A1_sim==B(2));
    indexes_sim_15 = find(A1_sim==B(3));
    indexes_sim_17 = find(A1_sim==B(4));
    indexes_sim_20 = find(A1_sim==B(5));
    
    indexes_sim = [indexes_sim_11;indexes_sim_13;indexes_sim_15;indexes_sim_17;indexes_sim_20];
    numsSim = A1_sim(indexes_sim);
    ansSim = A2_sim(indexes_sim);
    
    
    
    
    
    for i = 1:length(numsAud)
        indx = find(numsAud(i) == B);
        if numsAud(i) <10 && ansAud(i) == 0
            num_greater_resp_aud(indx,s) = num_greater_resp_aud(indx,s) + 1;
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        elseif numsAud(i) < 10 && ansAud(i) == 1
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        elseif numsAud(i) > 10 && ansAud(i) == 0
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        elseif numsAud(i) > 10 && ansAud(i) == 1
            num_greater_resp_aud(indx,s) = num_greater_resp_aud(indx,s) + 1;
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        end;
    end;
    
    
    for i = 1:length(numsVis)
        indx = find(numsVis(i) == B);
        if numsVis(i) <10 && ansVis(i) == 0
            num_greater_resp_vis(indx,s) = num_greater_resp_vis(indx,s) + 1;
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        elseif numsVis(i) < 10 && ansVis(i) == 1
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        elseif numsVis(i) > 10 && ansVis(i) == 0
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        elseif numsVis(i) > 10 && ansVis(i) == 1
            num_greater_resp_vis(indx,s) = num_greater_resp_vis(indx,s) + 1;
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        end;
    end;
    
    for i = 1:length(numsSim)
        indx = find(numsSim(i) == B);
        if  numsSim(i) <10 && ansSim(i) == 0
            num_greater_resp_sim(indx,s) = num_greater_resp_sim(indx,s) + 1;
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        elseif numsSim(i) < 10 && ansSim(i) == 1
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        elseif  numsSim(i) > 10 && ansSim(i) == 0
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        elseif  numsSim(i) > 10 && ansSim(i) == 1
            num_greater_resp_sim(indx,s) = num_greater_resp_sim(indx,s) + 1;
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        end;
    end;
    
    
    data_vis(s,:) = num_greater_resp_vis(:,s); %number of greater than 10 responses per number in array B
    data_aud(s,:) = num_greater_resp_aud(:,s); %number of greater than 10 responses per number in array B
    data_sim(s,:) = num_greater_resp_sim(:,s); %number of greater than 10 responses per number in array B
    
    
    % arrange plot
    %figure(1);
    set(gcf,'NextPlot','add');
    
    subplot(5,5,s);
    
    set(gca,'FontSize',8);
    if type == 1
        axis([0 25 0 1]);
        set(gca,'XTick',[5 10 15 20]);
    else
        axis([0 log10(25) 0 1]);
        set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
    end;
    
    set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    
    
    %Palamedes function
    if type == 1
        StimLevels = B;
        paramsValues = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    NumPos = num_greater_resp_vis(:,s)';
    OutOfNum = num_total_resp_vis(:,s)';
    PF = @PAL_CumulativeNormal;
    
    paramsFree = [1 1 0 0];
    [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues,paramsFree,PF);
    if type == 1
        wf_vis(s,1) = abs(10-paramsValues(1))/10;
        %wf_vis(s,1) = paramsValues(1)/75;
    else
        %         wf_vis(s,1) = abs(10-10^paramsValues(1))/10;
        wf_vis(s,1) = 10^abs(1-paramsValues(1));
        %wf_vis(s,1) = (10^paramsValues(1))/75;
    end
    
    
    disp(strcat('Weber Fraction in log scale for vision for subject',num2str(subNo(s))));
    disp(wf_vis(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
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
        axis([0 25 0 1]);
        set(gca,'XTick',[5 10 15 20]);
    else
        axis([0 log10(25) 0 1]);
        set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
    end;
    set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    
    xlabel('Numbers');
    ylabel('Portion of Greater Responses');
    
    % arrange plot
    hold on;
    
    
    %Palamedes function
    if type == 1
        StimLevels = B;
        paramsValues = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    
    NumPos = num_greater_resp_aud(:,s)';
    OutOfNum = num_total_resp_aud(:,s)';
    PF = @PAL_CumulativeNormal;
    paramsFree = [1 1 0 0];
    [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues,paramsFree,PF);
    if type == 1
        wf_aud(s,1) = abs(10-paramsValues(1))/10;
        %wf_aud(s,1) = paramsValues(1)/75;
    else
        %         wf_aud(s,1) = abs(10-10^paramsValues(1))/10;
        wf_aud(s,1) = 10^abs(1-paramsValues(1));
        %wf_aud(s,1) = (10^paramsValues(1))/75;
    end
    
    disp(strcat('Weber Fraction in log scale for audition for subject',num2str(subNo(s))));
    disp(wf_aud(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
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
        axis([0 25 0 1]);
        set(gca,'XTick',[5 10 15 20]);
    else
        axis([0 log10(25) 0 1]);
        set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
    end;
    set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    
    
    %Palamedes function
    if type == 1
        StimLevels = B;
        paramsValues = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    NumPos = num_greater_resp_sim(:,s)';
    OutOfNum = num_total_resp_sim(:,s)';
    PF = @PAL_CumulativeNormal;
    
    paramsFree = [1 1 0 0];
    [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues,paramsFree,PF);
    if type == 1
        wf_sim(s,1) = abs(10-paramsValues(1))/10;
        %wf_sim(s,1) = paramsValues(1)/75;
    else
        %         wf_sim(s,1) = abs(10-10^paramsValues(1))/10;
        wf_sim(s,1) = 10^abs(1-paramsValues(1));
        %wf_sim(s,1) = (10^paramsValues(1))/75;
    end
    
    
    disp(strcat('Weber Fraction in log scale for simultaneous for subject',num2str(subNo(s))));
    disp(wf_sim(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
    %     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
    %         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues,StimLevelsFine);
    
    
    marker = 'db';
    plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',6);
    hold on;
    plot(StimLevelsFine,Fit,'g','LineWidth',3);
    
    set(gca,'FontSize',8);
    if type == 1
        axis([0 25 0 1]);
        set(gca,'XTick',[5 10 15 20]);
    else
        axis([0 log10(25) 0 1]);
        set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
    end;
    set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    
    xlabel('Numbers');
    ylabel('Portion of Greater Responses');
    
    % arrange plot
    hold on;
    
    title(strcat('Subject ',num2str(subNo(s))));
    
    if s == length(subNo)
        
        %get mean responses
        sum_greater_resp_vis = sum(data_vis(:,1:length(B)));
        sum_greater_resp_aud = sum(data_aud(:,1:length(B)));
        sum_greater_resp_sim = sum(data_sim(:,1:length(B)));
        
        sum_total_resp_vis = sum(num_total_resp_vis(1:length(B),:),2);
        sum_total_resp_aud = sum(num_total_resp_aud(1:length(B),:),2);
        sum_total_resp_sim = sum(num_total_resp_sim(1:length(B),:),2);
        
        
        minstim=min(B/1.7);
        maxstim=max(B*1.7);
        yscale = [0 1];
        % arrange plot
        subplot(5,5,s+1);
        set(gca,'FontSize',8);
        if type == 1
            axis([0 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([0 log10(25) 0 1]);
            set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        
        
        %Palamedes function
        if type == 1
            StimLevels = B;
            paramsValues = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_vis;
        OutOfNum = sum_total_resp_vis';
        PF = @PAL_CumulativeNormal;
        
        paramsFree = [1 1 0 0];
        [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues,paramsFree,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        
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
            axis([0 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([0 log10(25) 0 1]);
            set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        
        xlabel('Numbers');
        ylabel('Portion of Greater Responses');
        
        
        % arrange plot
        hold on;
        
        %Palamedes function
        if type == 1
            StimLevels = B;
            paramsValues = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_aud;
        OutOfNum = sum_total_resp_aud';
        PF = @PAL_CumulativeNormal;
        
        paramsFree = [1 1 0 0];
        [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues,paramsFree,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        
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
            axis([0 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([0 log10(25) 0 1]);
            set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        
        
        
        %Palamedes function
        if type == 1
            StimLevels = B;
            paramsValues = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_sim;
        OutOfNum = sum_total_resp_sim';
        PF = @PAL_CumulativeNormal;
        
        paramsFree = [1 1 0 0];
        [paramsValues LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues,paramsFree,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'db';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',6);
        
        hold on;
        
        plot(StimLevelsFine,Fit,'g','LineWidth',3);
        
        set(gca,'FontSize',8);
        if type == 1
            axis([0 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([0 log10(25) 0 1]);
            set(gca,'XTick',[log10(5) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        
        xlabel('Numbers');
        ylabel('Portion of Greater Responses');
        
        
        
        
        title('Mean data over all subjects');
        legend('Visual Data','Visual Fit','Auditory Data','Auditory Fit','Simultaneous Data','Simultaneous Fit');
        
        [H,P,CI,STATS] = ttest(wf_vis,wf_aud);
        disp('Results of ttest between WF for vision and audition:');
        disp(P);
        disp(STATS);
        
        
        [H,P,CI,STATS] = ttest(wf_vis,wf_sim);
        disp('Results of ttest between WF for vision and simultaneous:');
        disp(P);
        disp(STATS);
        
        
        
        [H,P,CI,STATS] = ttest(wf_aud,wf_sim);
        disp('Results of ttest between WF for auditory and simultaneous:');
        disp(P);
        disp(STATS);
        
        
        
        disp('Mean WF visual:');
        disp(mean(wf_vis));
        
        disp('Mean WF auditory:');
        disp(mean(wf_aud));
        
        disp('Mean WF simultaneous:');
        disp(mean(wf_sim));
        
        disp('Std WF visual:');
        disp(std(wf_vis));
        
        
        disp('Std WF auditory:');
        disp(std(wf_aud));
        
        disp('Std WF simultaneous:');
        disp(std(wf_sim));
        
        
    end;
end

stdAud = std(wf_aud);
stdVis = std(wf_vis);

[wA,wV] = findWeights(stdAud,stdVis);

disp('Weight of auditory modality according to MLE:');
disp(wA);

disp('Weight of visual modality according to MLE:');
disp(wV);

stdSim = (stdAud^2*stdVis^2)/(stdAud^2+stdVis^2);
disp('Std for simultanoeus case according to MLE:');
disp(stdSim);
disp('Real std for simultaneous case:');
disp(std(wf_sim));
%[H,P,CI,STATS] = ttest(R2_lin,R2_log); % to test whether log scale fits better than lin scale
