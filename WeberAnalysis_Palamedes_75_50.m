function [WF_log]= WeberAnalysis_Palamedes()

%Weber analysis-calculate weber fraction with reference numerosity of 10.
%dat file in the form:
% col 1:    number to be compared
% col 2:    answer of the subject (corr = 1; wrong = 0)

%Author: Seda Cavdaroglu
%Date: 19.09.2013
subNo = [2,3,4,6,7,8,9,10,11,12,13,14,15,16,18,19];

B = [5,6,7,8,9,11,13,15,17,20];
type = 2;%1= linear, 2 = log scale

data_aud = zeros(length(subNo),length(B));
data_vis = zeros(length(subNo),length(B));
data_sim = zeros(length(subNo),length(B));
wf_aud = zeros(length(subNo),1);
wf_vis = zeros(length(subNo),1);
wf_sim = zeros(length(subNo),1);
pse_aud = zeros(length(subNo),1);
pse_vis = zeros(length(subNo),1);
pse_sim = zeros(length(subNo),1);
acc_aud = zeros(length(subNo),1);
acc_vis = zeros(length(subNo),1);
acc_sim = zeros(length(subNo),1);

acc_aud_pernum = zeros(length(subNo),length(B));
acc_vis_pernum = zeros(length(subNo),length(B));
acc_sim_pernum = zeros(length(subNo),length(B));


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
    
    A_vis = A_vis';
    A1_vis = A_vis(:,1); %first row of A = numbers used
    A2_vis = A_vis(:,2); %second row of A = responses
    
    
    A_sim = A_sim';
    A1_sim = A_sim(:,1); %first row of A = numbers used
    A2_sim = A_sim(:,2); %second row of A = responses
    

    num_corr_resp_aud = 0;
    num_corr_resp_vis = 0;
    num_corr_resp_sim = 0;
    
    num_corr_resp_aud_pernum = zeros(length(B),1);
    num_corr_resp_vis_pernum = zeros(length(B),1);
    num_corr_resp_sim_pernum = zeros(length(B),1);
    
    
    for i = 1:length(A1_aud)
        indx = find(A1_aud(i) == B);
        if A1_aud(i) <10 && A2_aud(i) == 0
            num_greater_resp_aud(indx,s) = num_greater_resp_aud(indx,s) + 1;
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        elseif A1_aud(i) < 10 && A2_aud(i) == 1
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
            num_corr_resp_aud = num_corr_resp_aud + 1;
            num_corr_resp_aud_pernum(indx,1) = num_corr_resp_aud_pernum(indx,1)+1;
        elseif A1_aud(i) > 10 && A2_aud(i) == 0
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
        elseif A1_aud(i) > 10 && A2_aud(i) == 1
            num_greater_resp_aud(indx,s) = num_greater_resp_aud(indx,s) + 1;
            num_total_resp_aud(indx,s) = num_total_resp_aud(indx,s) + 1;
            num_corr_resp_aud = num_corr_resp_aud + 1;
            num_corr_resp_aud_pernum(indx,1) = num_corr_resp_aud_pernum(indx,1)+1;
        end;
    end;
    
    
    for i = 1:length(A1_vis)
        indx = find(A1_vis(i) == B);
        if A1_vis(i) <10 && A2_vis(i) == 0
            num_greater_resp_vis(indx,s) = num_greater_resp_vis(indx,s) + 1;
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        elseif A1_vis(i) < 10 && A2_vis(i) == 1
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
            num_corr_resp_vis = num_corr_resp_vis + 1;
            num_corr_resp_vis_pernum(indx,1) = num_corr_resp_vis_pernum(indx,1)+1;
        elseif A1_vis(i) > 10 && A2_vis(i) == 0
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
        elseif A1_vis(i) > 10 && A2_vis(i) == 1
            num_greater_resp_vis(indx,s) = num_greater_resp_vis(indx,s) + 1;
            num_total_resp_vis(indx,s) = num_total_resp_vis(indx,s) + 1;
            num_corr_resp_vis = num_corr_resp_vis + 1;
            num_corr_resp_vis_pernum(indx,1) = num_corr_resp_vis_pernum(indx,1)+1;
        end;
    end;
    
    for i = 1:length(A1_sim)
        indx = find(A1_sim(i) == B);
        if A1_sim(i) <10 && A2_sim(i) == 0
            num_greater_resp_sim(indx,s) = num_greater_resp_sim(indx,s) + 1;
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        elseif A1_sim(i) < 10 && A2_sim(i) == 1
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
            num_corr_resp_sim = num_corr_resp_sim + 1;
            num_corr_resp_sim_pernum(indx,1) = num_corr_resp_sim_pernum(indx,1)+1;
        elseif A1_sim(i) > 10 && A2_sim(i) == 0
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
        elseif A1_sim(i) > 10 && A2_sim(i) == 1
            num_greater_resp_sim(indx,s) = num_greater_resp_sim(indx,s) + 1;
            num_total_resp_sim(indx,s) = num_total_resp_sim(indx,s) + 1;
            num_corr_resp_sim = num_corr_resp_sim + 1;
            num_corr_resp_sim_pernum(indx,1) = num_corr_resp_sim_pernum(indx,1)+1;
        end;
    end;
    
    
    data_vis(s,:) = num_greater_resp_vis(:,s); %number of greater than 10 responses per number in array B
    data_aud(s,:) = num_greater_resp_aud(:,s); %number of greater than 10 responses per number in array B
    data_sim(s,:) = num_greater_resp_sim(:,s); %number of greater than 10 responses per number in array B
    

    acc_vis(s,1) = num_corr_resp_vis/sum(num_total_resp_vis(:,s));
    acc_aud(s,1) = num_corr_resp_aud/sum(num_total_resp_aud(:,s));
    acc_sim(s,1) = num_corr_resp_sim/sum(num_total_resp_sim(:,s));
    
    
    
    acc_vis_pernum(s,:) = num_corr_resp_vis_pernum./num_total_resp_vis(:,s);
    acc_aud_pernum(s,:) = num_corr_resp_aud_pernum./num_total_resp_aud(:,s);
    acc_sim_pernum(s,:) = num_corr_resp_sim_pernum./num_total_resp_sim(:,s);
    
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
        paramsValues_75 = [11 0.2 0.5 0];
        paramsValues_50 = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues_75 = [1.1 6 0.5 0];
        paramsValues_50 = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    NumPos = num_greater_resp_vis(:,s)';
    OutOfNum = num_total_resp_vis(:,s)';
    PF = @PAL_CumulativeNormal;
    
    paramsFree_75 = [1 1 0.5 0];
    paramsFree_50 = [1 1 0 0];
    [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
    [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
    if type == 1
        wf_vis(s,1) = abs(paramsValues_50(1)-paramsValues_75(1))/10;
        thres_vis(s,1) = abs(paramsValues_50(1)-paramsValues_75(1));
        pse_vis(s,1) = paramsValues_50(1);
        %wf_vis(s,1) = paramsValues_75(1)/75;
    else
        wf_vis(s,1) = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
        thres_vis(s,1) = abs(10^paramsValues_75(1)-10^paramsValues_50(1)); 
        pse_vis(s,1) = 10^paramsValues_50(1);
        %wf_vis(s,1) = abs(10-10^paramsValues_75(1))/10;
        %wf_vis(s,1) = (10^paramsValues_75(1))/75;
    end
    
    
%     disp(strcat('Weber Fraction in log scale for vision for subject',num2str(subNo(s))));
%     disp(wf_vis(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
    %     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
    %         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues_75,StimLevelsFine);
    
    
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
        paramsValues_75 = [11 0.2 0.5 0];
        paramsValues_50 = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues_75 = [1.1 6 0.5 0];
        paramsValues_50 = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    
    NumPos = num_greater_resp_aud(:,s)';
    OutOfNum = num_total_resp_aud(:,s)';
    PF = @PAL_CumulativeNormal;
    paramsFree_75 = [1 1 0.5 0];
    paramsFree_50 = [1 1 0 0];
    [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
    [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
    if type == 1
        wf_aud(s,1) = abs(paramsValues_50(1)-paramsValues_75(1))/10;
        thres_aud(s,1) = abs(paramsValues_50(1)-paramsValues_75(1));
        pse_aud(s,1) = paramsValues_50(1);
    else
        wf_aud(s,1) = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
        thres_aud(s,1) = abs(10^paramsValues_75(1)-10^paramsValues_50(1)); 
        pse_aud(s,1) = 10^paramsValues_50(1);

    end
    
%     disp(strcat('Weber Fraction in log scale for audition for subject',num2str(subNo(s))));
%     disp(wf_aud(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
    %     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
    %         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues_75,StimLevelsFine);
    
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
        paramsValues_75 = [11 0.2 0.5 0];
        paramsValues_50 = [11 0.2 0 0];
        maxStimLevels = 25;
    else
        StimLevels =log10(B);
        paramsValues_75 = [1.1 6 0.5 0];
        paramsValues_50 = [1.1 6 0 0];
        maxStimLevels = log10(25);
    end;
    NumPos = num_greater_resp_sim(:,s)';
    OutOfNum = num_total_resp_sim(:,s)';
    PF = @PAL_CumulativeNormal;
    
    paramsFree_75 = [1 1 0.5 0];
    paramsFree_50 = [1 1 0 0];
    [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
    [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
        NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
    if type == 1
        wf_sim(s,1) = abs(paramsValues_50(1)-paramsValues_75(1))/10;
        thres_sim(s,1) = abs(paramsValues_75(1)-paramsValues_50(1));
        pse_sim(s,1) = paramsValues_50(1);
        %wf_sim(s,1) = paramsValues_75(1)/75;
    else
        wf_sim(s,1) = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
        thres_sim(s,1) = abs(10^paramsValues_75(1)-10^paramsValues_50(1)); 
        pse_sim(s,1) = 10^paramsValues_50(1);
        %         wf_sim(s,1) = abs(10-10^paramsValues_75(1))/10;
        %wf_sim(s,1) = (10^paramsValues_75(1))/75;
    end
    
    
%     disp(strcat('Weber Fraction in log scale for simultaneous for subject',num2str(subNo(s))));
%     disp(wf_sim(s,1));
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
    %     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
    %         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues_75,StimLevelsFine);
    
    
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
        sum_greater_resp_vis = sum(data_vis(:,1:10));
        sum_greater_resp_aud = sum(data_aud(:,1:10));
        sum_greater_resp_sim = sum(data_sim(:,1:10));
        
        sum_total_resp_vis = sum(num_total_resp_vis(1:10,:),2);
        sum_total_resp_aud = sum(num_total_resp_aud(1:10,:),2);
        sum_total_resp_sim = sum(num_total_resp_sim(1:10,:),2);
        
        
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
            paramsValues_75 = [11 0.2 0.5 0];
            paramsValues_50 = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues_75 = [1.1 6 0.5 0];
            paramsValues_50 = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_vis;
        OutOfNum = sum_total_resp_vis';
        PF = @PAL_CumulativeNormal;
        
        paramsFree_75 = [1 1 0.5 0];
        paramsFree_50 = [1 1 0 0];
        [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
        [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
        
        if type == 1
            wf_mean_vis = abs(paramsValues_50(1)-paramsValues_75(1))/10;
            thres_mean_vis = abs(paramsValues_50(1)-paramsValues_75(1));
            pse_mean_vis = paramsValues_50(1);
            %wf_aud(s,1) = paramsValues_75(1)/75;
        else
            wf_mean_vis = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
            thres_mean_vis = abs(10^paramsValues_75(1)-10^paramsValues_50(1)); 
            pse_mean_vis = 10^paramsValues_50(1);
            %         wf_aud(s,1) = abs(10-10^paramsValues_75(1))/10;
            %wf_aud(s,1) = (10^paramsValues_75(1))/75;
        end
        
        
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLe vels))./1000:max(StimLevels)];
        Fit = PF(paramsValues_75,StimLevelsFine);
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
            paramsValues_75 = [11 0.2 0.5 0];
            paramsValues_50 = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues_75 = [1.1 6 0.5 0];
            paramsValues_50 = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_aud;
        OutOfNum = sum_total_resp_aud';
        PF = @PAL_CumulativeNormal;
        
        paramsFree_75 = [1 1 0.5 0];
        paramsFree_50 = [1 1 0 0];
        [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
        [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        if type == 1
            wf_mean_aud = abs(paramsValues_50(1)-paramsValues_75(1))/10;
            thres_mean_aud = abs(paramsValues_50(1)-paramsValues_75(1));
            pse_mean_aud = paramsValues_50(1);
            %wf_aud(s,1) = paramsValues_75(1)/75;
        else
            wf_mean_aud = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
            thres_mean_aud = abs(10^paramsValues_75(1)-10^paramsValues_75(1)); 
            pse_mean_aud = 10^paramsValues_50(1);
            %         wf_aud(s,1) = abs(10-10^paramsValues_75(1))/10;
            %wf_aud(s,1) = (10^paramsValues_75(1))/75;
        end
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues_75,StimLevelsFine);
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
            paramsValues_75 = [11 0.2 0.5 0];
            paramsValues_50 = [11 0.2 0 0];
            maxStimLevels = 25;
        else
            StimLevels =log10(B);
            paramsValues_75 = [1.1 6 0.5 0];
            paramsValues_50 = [1.1 6 0 0];
            maxStimLevels = log10(25);
        end;
        NumPos = sum_greater_resp_sim;
        OutOfNum = sum_total_resp_sim';
        PF = @PAL_CumulativeNormal;
        
        paramsFree_75 = [1 1 0.5 0];
        paramsFree_50 = [1 1 0 0];
        [paramsValues_75 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_75,paramsFree_75,PF);
        [paramsValues_50 LL exitflag] = PAL_PFML_Fit(StimLevels,...
            NumPos,OutOfNum,paramsValues_50,paramsFree_50,PF);
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        if type == 1
            wf_mean_sim = abs(paramsValues_50(1)-paramsValues_75(1))/10;
            thres_mean_sim = abs(paramsValues_50(1)-paramsValues_75(1));
            pse_mean_sim = paramsValues_50(1);
            %wf_aud(s,1) = paramsValues_75(1)/75;
        else
            wf_mean_sim = abs(10^paramsValues_50(1)-10^paramsValues_75(1))/10;
            thres_mean_sim = abs(10^paramsValues_75(1)-10^paramsValues_50(1)); 
            pse_mean_sim = paramsValues_50(1);
            %         wf_aud(s,1) = abs(10-10^paramsValues_75(1))/10;
            %wf_aud(s,1) = (10^paramsValues_75(1))/75;
        end
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues_75,StimLevelsFine);
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
        disp(wf_mean_vis);
        
        disp('Mean WF auditory:');
        disp(mean(wf_aud));
        disp(wf_mean_aud);
        
        disp('Mean WF simultaneous:');
        disp(mean(wf_sim));
        disp(wf_mean_sim);
        
        disp('Std visual:');
        disp(thres_mean_vis);
        
        
        disp('Std auditory:');
        disp(thres_mean_aud);
        
        disp('Std simultaneous:');
        disp(thres_mean_sim);
        
        
    end;
end

% stdAud = std(wf_aud);
% stdVis = std(wf_vis);
% 
% [wA,wV] = findWeights(stdAud,stdVis);
% 
% disp('Weight of auditory modality according to MLE:');
% disp(wA);
% 
% disp('Weight of visual modality according to MLE:');
% disp(wV);
% 
% stdSim = (stdAud^2*stdVis^2)/(stdAud^2+stdVis^2);
% disp('Std for simultanoeus case according to MLE:');
% disp(stdSim);
% disp('Real std for simultaneous case:');
% disp(std(wf_sim));
%[H,P,CI,STATS] = ttest(R2_lin,R2_log); % to test whether log scale fits better than lin scale



%ttestt betweeb accuracies in auditory and visual and simultaneous
disp('Mean accuracy auditory:');
disp(mean(acc_aud));
disp('Std accuracy auditory:');
disp(std(acc_aud));

disp('Mean accuracy visual:');
disp(mean(acc_vis));
disp('Std accuracy visual:');
disp(std(acc_vis));

disp('Mean accuracy simultaneous:');
disp(mean(acc_sim));
disp('Std accuracy simultaneous:');
disp(std(acc_sim));


[H,P,CI,STATS] = ttest(acc_aud,acc_vis);
disp('Results of ttest between accuracy for vision and audition:');
disp(P);
disp(STATS);



[H,P,CI,STATS] = ttest(acc_aud,acc_sim);
disp('Results of ttest between accuracy for auditory and simultaneous:');
disp(P);
disp(STATS);

[H,P,CI,STATS] = ttest(acc_vis,acc_sim);
disp('Results of ttest between accuracy for vision and simultaneous:');
disp(P);
disp(STATS);



%%
%test goodness of fit of MLE model
est_aud = zeros(length(subNo),1);
est_vis = zeros(length(subNo),1);
est_sim = zeros(length(subNo),1);
wf_est_sim = zeros(length(subNo),1);
for i = 1:length(subNo)
    var_aud = 1/(thres_aud(s,1)^2);
    var_vis = 1/(thres_aud(s,1)^2);
    var_sim = 1/(thres_aud(s,1)^2);
    
    est_sim(i,1) = sqrt((thres_aud(i,1)^2)*(thres_vis(i,1)^2)/(thres_aud(i,1)^2+thres_vis(i,1)^2));
%     disp('Auditory threshold:');
%     disp(thres_aud(i,1));
%     disp('Visual threshold:');
%     disp(thres_vis(i,1));
%     disp('Simultaneous threshold:');
%     disp(thres_sim(i,1));
%     disp('Simultaneous estimated threshold:');
%     disp(est_sim(i,1));
%     est_aud(i,1) = var_aud/(var_aud+var_vis);
%     est_vis(i,1) = var_vis/(var_aud+var_vis);
    wf_est_sim(i,1) = sqrt((wf_aud(i,1)^2*wf_vis(i,1)^2)/(wf_aud(i,1)^2+wf_vis(i,1)^2));
end;

% disp('Mean weight for auditory based on thresholds:');
% disp(mean(est_aud)); 
% disp('Mean weight for visual based on thresholds:');
% disp(mean(est_vis));
%test if the variance estimated with MLE differs significantly from
%real variance in simultaneous trials
% disp('est_sim:');
% disp(est_sim);
% disp('thres_sim:');
% disp(thres_sim);
% [H,P,CI,STATS] = ttest(est_sim,thres_sim);
% disp('test if mle is a good estimate for simultaneus processing or not:');
% disp(P);
% disp(STATS);


disp('wf_sim:');
disp(wf_sim);
disp('estimate wf_sim:');
disp(wf_est_sim);
[H,P,CI,STATS] = ttest(wf_sim,wf_est_sim);
disp('test if mle is a good estimate for simultaneus processing or not:');
disp(P);
disp(STATS);



% disp('Mean sim threshold in real data:');
% disp(mean(thres_sim));
% disp('Mean sim threshold estimated by MLE:');
% disp(mean(est_sim));
% 
% disp('Mean vis threshold in real data:');
% disp(mean(thres_vis));
% disp('Mean aud threshold in real data:');
% disp(mean(thres_aud));
% disp('Accuracy for small numbers in auditory domain:');
% disp(mean(mean(acc_aud_pernum(:,1:5))));
% disp('Accuracy for small numbers in visual domain:');
% disp(mean(mean(acc_vis_pernum(:,1:5))));
% disp('Accuracy for small numbers simultaneous:');
% disp(mean(mean(acc_sim_pernum(:,1:5))));
% 
% disp('Accuracy for large numbers in auditory domain:');
% disp(mean(mean(acc_aud_pernum(:,6:10))));
% disp('Accuracy for large numbers in visual domain:');
% disp(mean(mean(acc_vis_pernum(:,6:10))));
% disp('Accuracy for large numbers simultaneous:');
% disp(mean(mean(acc_sim_pernum(:,6:10))));
% 
% 
% 
% small_acc_aud= mean(acc_aud_pernum(:,1:5));
% small_acc_vis = mean(acc_vis_pernum(:,1:5));
% small_acc_sim = mean(acc_sim_pernum(:,1:5));
% 
% large_acc_aud= mean(acc_aud_pernum(:,6:10));
% large_acc_vis = mean(acc_vis_pernum(:,6:10));
% large_acc_sim = mean(acc_sim_pernum(:,6:10));
% 
% disp('test of symmetry for auditory:');
% [H,P,CI,STATS] = ttest(small_acc_aud,large_acc_aud);
% disp(P);
% disp('test of symmetry for visual:');
% [H,P,CI,STATS] = ttest(small_acc_vis,large_acc_vis);
% disp(P);
% disp('test of symmetry for auditory:');
% [H,P,CI,STATS] = ttest(small_acc_sim,large_acc_sim);
% disp(P);
