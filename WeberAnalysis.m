function [WF_log]= WeberAnalysis()

%Weber analysis-calculate weber fraction with reference numerosity of 10.
%dat file in the form:
% col 1:    number to be compared
% col 2:    answer of the subject (corr = 1; wrong = 0)

%Author: Seda Cavdaroglu
%Date: 19.09.2013
subNo = 1:1:5;
type = 3;
B = [5,6,7,8,9,11,13,15,17,20];
wf_aud = zeros(length(subNo),1);
wf_vis = zeros(length(subNo),1);
data_aud = zeros(length(subNo),length(B));
data_vis = zeros(length(subNo),length(B));
%figure(1);
figure('Color',[1 1 1]);
for s = 1:length(subNo)
    %open the text file to read the output
    if type == 1 %open the visual file
        subj_file = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/log_files/vis_subject_',num2str(subNo(s)),'.txt');
    elseif type == 2 %open the auditory file
        subj_file = strcat('/home/user/project2/Psychophysics/MultiSensory/auditoryDany/log_files/aud_subject_',num2str(subNo(s)),'.txt');
    else %open both files
        subj_file_vis = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/log_files/vis_subject_',num2str(subNo(s)),'.txt');
        subj_file_aud = strcat('/home/user/project2/Psychophysics/MultiSensory/auditoryDany/log_files/aud_subject_',num2str(subNo(s)),'.txt');
    end;

    yscale = [0 100];


    if type == 1 || type == 2
        fid = fopen(subj_file);
        A = fscanf(fid, '%g %g', [2 inf]);
        fclose(fid);

        % Transpose so that A matches
        % the orientation of the file
        A = A';
        A1 = A(:,1); %first row of A = numbers used
        A2 = A(:,2); %second row of A = responses
        


        refNum = 10;
        num_greater_resp = zeros(length(B),1);
        num_total_resp = zeros(length(B),1);

        for i = 1:length(A1)
            indx = find(A1(i) == B);
            if A1(i) <10 && A2(i) == 0
                num_greater_resp(indx) = num_greater_resp(indx) + 1;
                num_total_resp(indx) = num_total_resp(indx) + 1;
            elseif A1(i) < 10 && A2(i) == 1
                num_total_resp(indx) = num_total_resp(indx) + 1;
            elseif A1(i) > 10 && A2(i) == 0
                num_total_resp(indx) = num_total_resp(indx) + 1;
            elseif A1(i) > 10 && A2(i) == 1
                num_greater_resp(indx) = num_greater_resp(indx) + 1;
                num_total_resp(indx) = num_total_resp(indx) + 1;
            end;
        end;

        prop_greater_resp = num_greater_resp ./ num_total_resp; %proportion of greater than 10 responses per number in array B

        fitfunction = 'CompPerfBias';

        %LINEAR SCALE
    %     xreg = B-10;
    %     yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
    %     beta0 = [mean(prop_greater_resp) std(prop_greater_resp)]; %%%% seed the Weber fraction
    %     [beta,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);
    %     R2_lin = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
    %     WF_lin = beta(1);
    %     disp('Weber Fraction in linear scale:');
    %     disp(WF_lin);
    %     minstim=min(B)/1.7;
    %     maxstim=max(B)*1.7;
    %     figure(1);
    %     clf;
    %     hold on;
    %     set(gca,'FontSize',18);
    %     axis([minstim maxstim yscale]);
    %     set(gca,'XTick',[5 10 15 20]);
    %     set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    % 
    %     range = 1:10;
    %     marker = 'sr';
    %     stimrange = minstim:(maxstim-minstim)/100:maxstim;
    %     plot(B(range),yreg(range),marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',12);
    %     plot(stimrange,feval(fitfunction,beta,stimrange-refNum),marker,'LineWidth',3);  


        minstim=min(log(B/1.7));
        maxstim=max(log(B*1.7));
        % arrange plot
        figure(2);
        clf;
        hold on;
        set(gca,'FontSize',18);
        axis([log(3) maxstim yscale ]);
        set(gca,'XTick',log([5 10 15 20]));
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });


        %LOG SCALE
        lgxvalues = log10(B);
        beta0 = [0.15 0]; %%%% seed the Weber fraction 
        xreg = lgxvalues;
        xreg = xreg-log10(10); %difference between refNum and num in log scale
        yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
        [wf,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);%;
        %R2_log = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
        WF_log= wf(1);
        disp('Weber Fraction in log scale:');
        disp(WF_log);

        range = 1:10;
        marker = 'db'; 
        plot(log(B(range)),yreg(range),marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',12);


        marker = 'sr';
        stimrange = minstim:(maxstim-minstim)/100:maxstim;
        plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),marker,'LineWidth',3);  
    elseif type == 3 %draw the psychophysics curves of both modalities in one graph
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
        B = [5,6,7,8,9,11,13,15,17,20];


        refNum = 10;
        num_greater_resp_aud = zeros(length(B),1);
        num_total_resp_aud = zeros(length(B),1);
        num_greater_resp_vis = zeros(length(B),1);
        num_total_resp_vis = zeros(length(B),1);

        for i = 1:length(A1_aud)
            indx = find(A1_aud(i) == B);
            if A1_aud(i) <10 && A2_aud(i) == 0
                num_greater_resp_aud(indx) = num_greater_resp_aud(indx) + 1;
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) < 10 && A2_aud(i) == 1
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) > 10 && A2_aud(i) == 0
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) > 10 && A2_aud(i) == 1
                num_greater_resp_aud(indx) = num_greater_resp_aud(indx) + 1;
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            end;
        end;


        for i = 1:length(A1_vis)
            indx = find(A1_vis(i) == B);
            if A1_vis(i) <10 && A2_vis(i) == 0
                num_greater_resp_vis(indx) = num_greater_resp_vis(indx) + 1;
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) < 10 && A2_vis(i) == 1
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) > 10 && A2_vis(i) == 0
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) > 10 && A2_vis(i) == 1
                num_greater_resp_vis(indx) = num_greater_resp_vis(indx) + 1;
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            end;
        end;

        prop_greater_resp_vis = num_greater_resp_vis ./ num_total_resp_vis; %proportion of greater than 10 responses per number in array B
        prop_greater_resp_aud = num_greater_resp_aud ./ num_total_resp_aud; %proportion of greater than 10 responses per number in array B
        data_vis(s,:) = num_greater_resp_vis ./ num_total_resp_vis; %proportion of greater than 10 responses per number in array B
        data_aud(s,:) = num_greater_resp_aud ./ num_total_resp_aud; %proportion of greater than 10 responses per number in array B 

        %fit cumulative gaussian function to the data
        fitfunction = 'CompPerfBias';

        %LINEAR SCALE
    %     xreg = B-10;
    %     yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
    %     beta0 = [mean(prop_greater_resp) std(prop_greater_resp)]; %%%% seed the Weber fraction
    %     [beta,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);
    %     R2_lin = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
    %     WF_lin = beta(1);
    %     disp('Weber Fraction in linear scale:');
    %     disp(WF_lin);
    %     minstim=min(B)/1.7;
    %     maxstim=max(B)*1.7;
    %     figure(1);
    %     clf;
    %     hold on;
    %     set(gca,'FontSize',18);
    %     axis([minstim maxstim yscale]);
    %     set(gca,'XTick',[5 10 15 20]);
    %     set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    % 
    %     range = 1:10;
    %     marker = 'sr';
    %     stimrange = minstim:(maxstim-minstim)/100:maxstim;
    %     plot(B(range),yreg(range),marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',12);
    %     plot(stimrange,feval(fitfunction,beta,stimrange-refNum),marker,'LineWidth',3);  


        minstim=min(log(B/1.7));
        maxstim=max(log(B*1.7));
        % arrange plot
        %figure(1);
        set(gcf,'NextPlot','add');
        
        subplot(4,4,s);


        %clf;
        %hold on;
        set(gca,'FontSize',8);
        axis([log(3) maxstim yscale ]);
        set(gca,'XTick',log([5 10 15 20]));
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });


        %LOG SCALE
        lgxvalues = log10(B);
        beta0 = [0.15 0]; %%%% seed the Weber fraction 
        xreg = lgxvalues;
        xreg = xreg-log10(10); %difference between refNum and num in log scale
        yreg = 100.*prop_greater_resp_vis(1:10);% percentage at eeach comparison number
        [wf,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);%;
        %R2_log = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
        WF_log_vis= wf(1);
        wf_vis(s,1) = WF_log_vis;
        disp('Weber Fraction in log scale for vision:');
        disp(WF_log_vis);

        range = 1:10;
        marker = 'db';
        
        plot(log(B(range)),yreg(range),marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',6);
        %plot(log(B(range)),yreg(range),'b');
        hold on;

        marker = 'sb';
        stimrange = minstim:(maxstim-minstim)/100:maxstim;
        %plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),marker,'LineWidth',1.5); 
        plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),'b','LineWidth',3); 


        xlabel('Numbers');
        ylabel('Percentage of Greater Responses');
        

        %LINEAR SCALE
    %     xreg = B-10;
    %     yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
    %     beta0 = [mean(prop_greater_resp) std(prop_greater_resp)]; %%%% seed the Weber fraction
    %     [beta,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);
    %     R2_lin = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
    %     WF_lin = beta(1);
    %     disp('Weber Fraction in linear scale:');
    %     disp(WF_lin);
    %     minstim=min(B)/1.7;
    %     maxstim=max(B)*1.7;
    %     figure(1);
    %     clf;
    %     hold on;
    %     set(gca,'FontSize',18);
    %     axis([minstim maxstim yscale]);
    %     set(gca,'XTick',[5 10 15 20]);
    %     set(gca,'XTickLabel',{ '5' '10' '15' '20' });
    % 
    %     range = 1:10;
    %     marker = 'sr';
    %     stimrange = minstim:(maxstim-minstim)/100:maxstim;
    %     plot(B(range),yreg(range),marker,'MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',12);
    %     plot(stimrange,feval(fitfunction,beta,stimrange-refNum),marker,'LineWidth',3);  


        minstim=min(log(B/1.7));
        maxstim=max(log(B*1.7));
        % arrange plot
        hold on;


        %LOG SCALE
        lgxvalues = log10(B);
        beta0 = [0.15 0]; %%%% seed the Weber fraction 
        xreg = lgxvalues;
        xreg = xreg-log10(10); %difference between refNum and num in log scale
        yreg = 100.*prop_greater_resp_aud(1:10);% percentage at eeach comparison number
        [wf,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);%;
        %R2_log = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
        WF_log_aud= wf(1);
        wf_aud(s,1) = WF_log_aud;
        disp('Weber Fraction in log scale for auditory:');
        disp(WF_log_aud);

        range = 1:10;
        marker = 'dr'; 
        plot(log(B(range)),yreg(range),marker,'MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',6);
        %plot(log(B(range)),yreg(range),'r');
        hold on;

        marker = 'sr';
        stimrange = minstim:(maxstim-minstim)/100:maxstim;
        %plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),marker,'LineWidth',1.5); 
        plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),'r','LineWidth',3); 
        title(strcat('Subject ',num2str(s)));
        WF_log = [WF_log_vis,WF_log_aud];
        if s == length(subNo)
            
            %get mean responses for vision 
            prop_greater_resp_vis = mean(data_vis(:,1:10));
            prop_greater_resp_aud = mean(data_aud(:,1:10));
            
            minstim=min(log(B/1.7));
            maxstim=max(log(B*1.7));
            % arrange plot
            subplot(4,4,s+1);
            set(gca,'FontSize',8);
            axis([log(3) maxstim yscale ]);
            set(gca,'XTick',log([5 10 15 20]));
            set(gca,'XTickLabel',{ '5' '10' '15' '20' });


            %LOG SCALE
            lgxvalues = log10(B);
            beta0 = [0.15 0]; %%%% seed the Weber fraction 
            xreg = lgxvalues;
            xreg = xreg-log10(10); %difference between refNum and num in log scale
            yreg = 100.*prop_greater_resp_vis(1:10);% percentage at eeach comparison number
            [wf,r,j]=nlinfit(xreg,yreg,fitfunction,beta0);%;
            %R2_log = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
            WF_log_vis= wf(1);
            wf_vis(s,1) = WF_log_vis;
            disp('Weber Fraction in log scale for vision:');
            disp(WF_log_vis);

            range = 1:10;
            marker = 'db';

            plot(log(B(range)),yreg(range),marker,'MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',6);
            %plot(log(B(range)),yreg(range),'b');
            hold on;

            marker = 'sb';
            stimrange = minstim:(maxstim-minstim)/100:maxstim;
            %plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),marker,'LineWidth',1.5); 
            plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),'b','LineWidth',3); 
            

            xlabel('Numbers');
            ylabel('Percentage of Greater Responses');


            
            minstim=min(log(B/1.7));
            maxstim=max(log(B*1.7));
            % arrange plot
            hold on;


            %LOG SCALE
            lgxvalues = log10(B);
            beta0 = [0.15 0]; %%%% seed the Weber fraction 
            xreg = lgxvalues;
            xreg = xreg-log10(10); %difference between refNum and num in log scale
            yreg = 100.*prop_greater_resp_aud(1:10);% percentage at eeach comparison number
            [wf,r,j]=nlinfit(xreg,yreg,fitfunction,beta0);%;
            %R2_log = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
            WF_log_aud= wf(1);
            wf_aud(s,1) = WF_log_aud;
            disp('Weber Fraction in log scale for auditory:');
            disp(WF_log_aud);

            range = 1:10;
            marker = 'dr'; 
            plot(log(B(range)),yreg(range),marker,'MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',6);
            %plot(log(B(range)),yreg(range),'r');

            hold on;
            marker = 'sr';
            stimrange = minstim:(maxstim-minstim)/100:maxstim;
            %plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),marker,'LineWidth',1.5); 
            plot(stimrange,feval(fitfunction,wf,stimrange-log(refNum)),'r','LineWidth',3); 
            title('Mean data over all subjects');
            legend('Visual Data','Visual Fit','Auditory Data','Auditory Fit');
            WF_log = [WF_log_vis,WF_log_aud];
            
            [H,P,CI,STATS] = ttest(wf_vis,wf_aud);
            disp('Results of ttest between WF for vision and audition:');
            disp(P);
            disp(STATS);
        end;
    else %get WF from both modalities but do not draw any graphs (this mode is to be used for ttesting later on with diff_WF)
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
        B = [5,6,7,8,9,11,13,15,17,20];


        refNum = 10;
        num_greater_resp_aud = zeros(length(B),1);
        num_total_resp_aud = zeros(length(B),1);
        num_greater_resp_vis = zeros(length(B),1);
        num_total_resp_vis = zeros(length(B),1);

        for i = 1:length(A1_aud)
            indx = find(A1_aud(i) == B);
            if A1_aud(i) <refNum && A2_aud(i) == 0
                num_greater_resp_aud(indx) = num_greater_resp_aud(indx) + 1;
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) < refNum && A2_aud(i) == 1
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) > refNum && A2_aud(i) == 0
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            elseif A1_aud(i) > refNum && A2_aud(i) == 1
                num_greater_resp_aud(indx) = num_greater_resp_aud(indx) + 1;
                num_total_resp_aud(indx) = num_total_resp_aud(indx) + 1;
            end;
        end;


        for i = 1:length(A1_vis)
            indx = find(A1_vis(i) == B);
            if A1_vis(i) < refNum && A2_vis(i) == 0
                num_greater_resp_vis(indx) = num_greater_resp_vis(indx) + 1;
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) <refNum && A2_vis(i) == 1
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) > refNum && A2_vis(i) == 0
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            elseif A1_vis(i) > refNum && A2_vis(i) == 1
                num_greater_resp_vis(indx) = num_greater_resp_vis(indx) + 1;
                num_total_resp_vis(indx) = num_total_resp_vis(indx) + 1;
            end;
        end;

        prop_greater_resp_vis = num_greater_resp_vis ./ num_total_resp_vis; %proportion of greater than 10 responses per number in array B
        prop_greater_resp_aud = num_greater_resp_aud ./ num_total_resp_aud; %proportion of greater than 10 responses per number in array B


        %fit cumulative gaussian function to the data
        fitfunction = 'CompPerfBias';

        %LINEAR SCALE
    %     xreg = B-10;
    %     yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
    %     beta0 = [mean(prop_greater_resp) std(prop_greater_resp)]; %%%% seed the Weber fraction
    %     [beta,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);
    %     R2_lin = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
    %     WF_lin = beta(1);
    %     disp('Weber Fraction in linear scale:');
    %     disp(WF_lin);

        %LOG SCALE
        lgxvalues = log10(B);
        beta0 = [0.15 0]; %%%% seed the Weber fraction 
        xreg = lgxvalues;
        xreg = xreg-log10(10); %difference between refNum and num in log scale
        yreg = 100.*prop_greater_resp_vis(1:10);% percentage at eeach comparison number
        [wf,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);%;
        %R2_log_vis = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
        WF_log_vis= wf(1);


        %LINEAR SCALE
    %     xreg = B-10;
    %     yreg = 100.*prop_greater_resp(1:10);% percentage at eeach comparison number
    %     beta0 = [mean(prop_greater_resp) std(prop_greater_resp)]; %%%% seed the Weber fraction
    %     [beta,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);
    %     R2_lin_vis = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
    %     WF_lin_vis = beta(1);

        %LOG SCALE
        lgxvalues = log10(B);
        beta0 = [0.15 0]; %%%% seed the Weber fraction 
        xreg = lgxvalues;
        xreg = xreg-log10(10); %difference between refNum and num in log scale
        yreg = 100.*prop_greater_resp_aud(1:10);% percentage at eeach comparison number
        [wf,r,j]=nlinfit(xreg,yreg',fitfunction,beta0);%;
        %R2_log_aud = 1 - ( sum(r .^ 2) / sum( (yreg-mean(yreg)).^2 ));
        WF_log_aud= wf(1);

        WF_log = [WF_log_vis,WF_log_aud];
    end
end

%[H,P,CI,STATS] = ttest(R2_lin,R2_log); % to test whether log scale fits better than lin scale
