function drawWF()

%draws the figures for overall weber fraction for 3 modalities
%Author: Seda Cavdaroglu
%Date: 10.09.2014
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
jnd_aud = zeros(length(subNo),1);
jnd_vis = zeros(length(subNo),1);
jnd_sim = zeros(length(subNo),1);

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

    
    thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');

    if type == 1
        pse_vis(s,1) = paramsValues(1);
        jnd_vis(s,1) = abs(paramsValues(1)-thresh);
        wf_vis(s,1) = jnd_vis(s,1)/10;
    else
        pse_vis(s,1) = 10^paramsValues(1);
        jnd_vis(s,1) = 10^abs(paramsValues(1)-thresh);
        wf_vis(s,1) = jnd_vis(s,1)/10; 
    end
    
    
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
    %     StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
    %         min(StimLevels))./1000:max(StimLevels)];
    Fit = PF(paramsValues,StimLevelsFine);
    
    
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

    thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');

    if type == 1
        pse_aud(s,1) = paramsValues(1);
        jnd_aud(s,1) = abs(paramsValues(1)-thresh);
        wf_aud(s,1) = jnd_aud(s,1)/10;
    else
        pse_aud(s,1) = 10^paramsValues(1);
        jnd_aud(s,1) = 10^abs(paramsValues(1)-thresh);
        wf_aud(s,1) = jnd_aud(s,1)/10; 
    end
    

    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];

    Fit = PF(paramsValues,StimLevelsFine);
    
    
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

    thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');

    if type == 1
        pse_sim(s,1) = paramsValues(1);
        jnd_sim(s,1) = abs(paramsValues(1)-thresh);
        wf_sim(s,1) = jnd_sim(s,1)/10;
    else
        pse_sim(s,1) = 10^paramsValues(1);
        jnd_sim(s,1) = 10^abs(paramsValues(1)-thresh);
        wf_sim(s,1) = jnd_sim(s,1)/10; 
    end
    
    
    PropCorrectData = NumPos./OutOfNum;
    minStimLevels = 0;
    
    StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];

    Fit = PF(paramsValues,StimLevelsFine);
    
    

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
        
        set(gca,'FontSize',8);
        if type == 1
            axis([3 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([log10(3) log10(25) 0 1]);
            set(gca,'XTick',[log10(3) log10(10) log10(15) log10(20)]);
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
        
        thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');
        
        if type == 1
            pse_vis_mean = paramsValues(1);
            jnd_vis_mean = abs(paramsValues(1)-thresh);
            wf_vis_mean = jnd_vis_mean/10;
        else
            pse_vis_mean = 10^paramsValues(1);
            jnd_vis_mean = 10^abs(paramsValues(1)-thresh);
            wf_vis_mean = jnd_vis_mean/10;
        end
        
        PropCorrectData = NumPos./OutOfNum;
        minStimLevels = 0;
        
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLe vels))./1000:max(StimLevels)];
        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'dr';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','r','MarkerEdgeColor','r','MarkerSize',4);
        
        hold on;
        
        plot(StimLevelsFine,Fit,'r','LineWidth',1.5,'LineStyle','-');

        set(gca,'FontSize',8);
        if type == 1
            axis([3 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([log10(3) log10(25) 0 1]);
            set(gca,'XTick',[log10(3) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        

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
        
        
        
        thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');
        
        if type == 1
            pse_aud_mean = paramsValues(1);
            jnd_aud_mean = abs(paramsValues(1)-thresh);
            wf_aud_mean = jnd_aud_mean/10;
        else
            pse_aud_mean = 10^paramsValues(1);
            jnd_aud_mean = 10^abs(paramsValues(1)-thresh);
            wf_aud_mean = jnd_aud_mean/10;
        end
        
        
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];

        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'db';%'ok';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',4);
        hold on;
        
        plot(StimLevelsFine,Fit,'b','LineWidth',1.5,'LineStyle','-');
        
        set(gca,'FontSize',8);
        if type == 1
            axis([3 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([log10(3) log10(25) 0 1]);
            set(gca,'XTick',[log10(3) log10(10) log10(15) log10(20)]);
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

        
        thresh = PAL_CumulativeNormal(paramsValues,.75,'inverse');
        
        if type == 1
            pse_sim_mean = paramsValues(1);
            jnd_sim_mean = abs(paramsValues(1)-thresh);
            wf_sim_mean = jnd_sim_mean/10;
        else
            pse_sim_mean = 10^paramsValues(1);
            jnd_sim_mean = 10^abs(paramsValues(1)-thresh);
            wf_sim_mean = jnd_sim_mean/10;
        end
        
        
        StimLevelsFine = [minStimLevels:(maxStimLevels-minStimLevels)./1000:maxStimLevels];
        %         StimLevelsFine = [min(StimLevels):(max(StimLevels)-...
        %             min(StimLevels))./1000:max(StimLevels)];
        Fit = PF(paramsValues,StimLevelsFine);
        marker = 'dk';%'xk';
        plot(StimLevels,PropCorrectData,marker,'MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',4);
        
        hold on;
        
        plot(StimLevelsFine,Fit,'k','LineWidth',1.5,'LineStyle','-');
        
        set(gca,'FontSize',8);
        
        if type == 1
            axis([3 25 0 1]);
            set(gca,'XTick',[5 10 15 20]);
        else
            axis([log10(3) log10(25) 0 1]);
            set(gca,'XTick',[log10(3) log10(10) log10(15) log10(20)]);
        end;
        set(gca,'XTickLabel',{ '5' '10' '15' '20' });
        
        
        
        h = legend('visual data','visual fit','auditory data','auditory fit','multimodal data','multimodal fit','Location',[0.8,0.5,0.005,0.005],'Fontsize',8);
        set(h,'PlotBoxAspectRatioMode','manual');
        set(h,'PlotBoxAspectRatio',[1 0.5 1]);
        legend(h,'boxoff');
        
        box off;
        set(gcf,'PaperUnits','centimeters');
        xSize = 6; ySize =3.6;
        xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
        set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
        set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);
        

        xlabel('Number', 'Fontsize',8,'Fontweight','bold');
        ylabel('Greater Responses [%]', 'Fontsize',8,'Fontweight','bold');
        
        
        
        img = gcf();
        imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\psychCurve.tiff');
        print(img,imgname, '-dtiff', '-r800')
        
    end;
end

%%

%Draw the weber fraction for each modality (aud,vis,sim) along with
%standard error of mean bars

sem_vis = std(wf_vis)/sqrt(length(subNo));
sem_aud = std(wf_aud)/sqrt(length(subNo));
sem_sim = std(wf_sim)/sqrt(length(subNo));


mFigure = figure('Color',[1 1 1]);

set(gcf,'numbertitle','off','name','Weber Fraction') %change the title of the figure





% Create a uicontrol of type "text"
% mTextBox = uicontrol('style','text');
% set(mTextBox,'String','a','Fontweight','bold');
% 
% % To move the the Text Box around you can set and get the position of Text 
% %Box itself
% mTextBoxPosition = get(mTextBox,'Position');
% set(mTextBox,'Position',[10 230 10 15],'FontSize',8,'Fontweight','bold');
% % The array mTextBoxPosition has four elements
% % [x y length height]
% 
% % Something that I find useful is to set the Position Units to Characters, 
% %the default is pixels
% set(mTextBox,'Units','characters')
% % This means a Text Box with 3 lines of text will have a height of 3
% % Get the Color of the figure window
colorOfFigureWindow = get(mFigure,'Color');
% 
% %Set the BackgroundColor of the text box
% set(mTextBox,'BackgroundColor',colorOfFigureWindow)
h = annotation('textbox',[0.01 0.85 0.05 0.15],'String','a','FontSize',8,'Fontweight','bold','BackgroundColor',colorOfFigureWindow,'EdgeColor','none');



% bar([mean(wf_vis),mean(wf_aud),mean(wf_sim)],'w');
hold on;

sem = [sem_vis sem_aud sem_sim];
means = [mean(wf_vis) mean(wf_aud) mean(wf_sim)];
% plot([1,1],[mean(wf_vis)-sem_vis,mean(wf_vis)+sem_vis],'-k','LineWidth',4);
% plot([2,2],[mean(wf_aud)-sem_aud,mean(wf_aud)+sem_aud],'-k','LineWidth',4);
% plot([3,3],[mean(wf_sim)-sem_sim,mean(wf_sim)+sem_sim],'-k','LineWidth',4);
% handles = barweb([accVis,accAud], [semVis,semAud], [], [], [], [], [], bone, [], [], 1, 'axis');
% handles = barweb([accVis,accAud], [semVis,semAud], 0.3, ['Aud','Vis'], 'Accuracy', 'Modality', 'Accuracy', [0 0 0], 'none', ['auditory','vis'], 2, 'plot');
barmap=[0.7 0.7 0.7]; %[0.7 0.7 0.7] is grey, [ 0.05 .45 0.1] is green
colormap(barmap);
[hBar hErrorbar] = barwitherr(sem', [1 2 3],means');
set(hErrorbar(1),'LineWidth',1);



set(gcf,'PaperUnits','centimeters');
xSize = 6; ySize =3.6;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);

set(gca,'FontSize',8,'XTick',[1 2 3],'XTickLabel', {'visual','auditory','multimodal'});
xlabel('Modality', 'Fontsize',8, 'Fontweight','bold');
ylabel('Weber Fraction', 'Fontsize',8, 'Fontweight','bold');



img = gcf();
imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\wfBars.tiff');
print(img,imgname, '-dtiff', '-r800') 



%%

%Draw the weber fraction for each modality (aud,vis,sim) along with
%standard error of mean bars
std_pse_vis = (pse_vis-10)./10;
std_pse_aud = (pse_aud-10)./10;
std_pse_sim = (pse_sim-10)./10;

sem_vis = std(std_pse_vis)/sqrt(length(subNo));
sem_aud = std(std_pse_aud)/sqrt(length(subNo));
sem_sim = std(std_pse_sim)/sqrt(length(subNo));


mFigure = figure('Color',[1 1 1]);

set(gcf,'numbertitle','off','name','PSE') %change the title of the figure


% Create a uicontrol of type "text"
% mTextBox = uicontrol('style','text');
% set(mTextBox,'String','a','Fontweight','bold');
% 
% % To move the the Text Box around you can set and get the position of Text 
% %Box itself
% mTextBoxPosition = get(mTextBox,'Position');
% set(mTextBox,'Position',[10 230 10 15],'FontSize',8,'Fontweight','bold');
% % The array mTextBoxPosition has four elements
% % [x y length height]
% 
% % Something that I find useful is to set the Position Units to Characters, 
% %the default is pixels
% set(mTextBox,'Units','characters')
% % This means a Text Box with 3 lines of text will have a height of 3
% % Get the Color of the figure window
colorOfFigureWindow = get(mFigure,'Color');
% 
% %Set the BackgroundColor of the text box
% set(mTextBox,'BackgroundColor',colorOfFigureWindow)
h = annotation('textbox',[0.01 0.85 0.05 0.15],'String','b','FontSize',8,'Fontweight','bold','BackgroundColor',colorOfFigureWindow,'EdgeColor','none');


% bar([mean(wf_vis),mean(wf_aud),mean(wf_sim)],'w');
hold on;

sem = [sem_vis sem_aud sem_sim];
means = [mean(std_pse_vis) mean(std_pse_aud) mean(std_pse_sim)];
% plot([1,1],[mean(wf_vis)-sem_vis,mean(wf_vis)+sem_vis],'-k','LineWidth',4);
% plot([2,2],[mean(wf_aud)-sem_aud,mean(wf_aud)+sem_aud],'-k','LineWidth',4);
% plot([3,3],[mean(wf_sim)-sem_sim,mean(wf_sim)+sem_sim],'-k','LineWidth',4);
% handles = barweb([accVis,accAud], [semVis,semAud], [], [], [], [], [], bone, [], [], 1, 'axis');
% handles = barweb([accVis,accAud], [semVis,semAud], 0.3, ['Aud','Vis'], 'Accuracy', 'Modality', 'Accuracy', [0 0 0], 'none', ['auditory','vis'], 2, 'plot');
barmap=[0.7 0.7 0.7]; %[0.7 0.7 0.7] is grey, [ 0.05 .45 0.1] is green
colormap(barmap);
[hBar hErrorbar] = barwitherr(sem', [1 2 3],means');
set(hErrorbar(1),'LineWidth',1);



set(gcf,'PaperUnits','centimeters');
xSize = 6; ySize =3.6;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);

set(gca,'FontSize',8,'XTick',[1 2 3],'XTickLabel', {'visual','auditory','multimodal'});
xlabel('Modality', 'Fontsize',8, 'Fontweight','bold');
ylabel('Standardized PSE', 'Fontsize',8, 'Fontweight','bold');



img = gcf();
imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\pseBars.tiff');
print(img,imgname, '-dtiff', '-r800') 
%%

%Draw the accuracy for each modality (aud,vis,sim) along with
%standard error of mean bars

sem_vis = std(acc_vis)/sqrt(length(subNo));
sem_aud = std(acc_aud)/sqrt(length(subNo));
sem_sim = std(acc_sim)/sqrt(length(subNo));

sem = [sem_vis sem_aud sem_sim];
means = [mean(acc_vis) mean(acc_aud) mean(acc_sim)];

mFigure = figure('Color',[1 1 1]);

set(gcf,'numbertitle','off','name','Accuracy') %change the title of the figure


% Create a uicontrol of type "text"
% mTextBox = uicontrol('style','text');
% set(mTextBox,'String','a','Fontweight','bold');
% 
% % To move the the Text Box around you can set and get the position of Text 
% %Box itself
% mTextBoxPosition = get(mTextBox,'Position');
% set(mTextBox,'Position',[10 230 10 15],'FontSize',8,'Fontweight','bold');
% % The array mTextBoxPosition has four elements
% % [x y length height]
% 
% % Something that I find useful is to set the Position Units to Characters, 
% %the default is pixels
% set(mTextBox,'Units','characters')
% % This means a Text Box with 3 lines of text will have a height of 3
% % Get the Color of the figure window
colorOfFigureWindow = get(mFigure,'Color');
% 
% %Set the BackgroundColor of the text box
% set(mTextBox,'BackgroundColor',colorOfFigureWindow)
h = annotation('textbox',[0.01 0.85 0.05 0.15],'String','c','FontSize',8,'Fontweight','bold','BackgroundColor',colorOfFigureWindow,'EdgeColor','none');



% bar([mean(acc_vis),mean(acc_aud),mean(acc_sim)],'w');
hold on;
% 
% 
% plot([1,1],[mean(acc_vis)-sem_vis,mean(acc_vis)+sem_vis],'-k','LineWidth',4);
% plot([2,2],[mean(acc_aud)-sem_aud,mean(acc_aud)+sem_aud],'-k','LineWidth',4);
% plot([3,3],[mean(acc_sim)-sem_sim,mean(acc_sim)+sem_sim],'-k','LineWidth',4);
barmap=[0.7 0.7 0.7]; %[0.7 0.7 0.7] is grey, [ 0.05 .45 0.1] is green
colormap(barmap);
[hBar hErrorbar] = barwitherr(sem', [1 2 3],means');
set(hErrorbar(1),'LineWidth',1);
% errorbar([1 2 3],[mean(acc_vis) mean(acc_aud) mean(acc_sim)],[sem_vis sem_aud sem_sim],'k');
% handles = barweb([accVis,accAud], [semVis,semAud], [], [], [], [], [], bone, [], [], 1, 'axis');
% handles = barweb([accVis,accAud], [semVis,semAud], 0.3, ['Aud','Vis'], 'Accuracy', 'Modality', 'Accuracy', [0 0 0], 'none', ['auditory','vis'], 2, 'plot');
hold off;
set(gcf,'PaperUnits','centimeters');
xSize = 6; ySize =3.6;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);

set(gca,'FontSize',8,'XTick',[1 2 3],'XTickLabel', {'visual','auditory','multimodal'});
xlabel('Modality', 'Fontsize',8, 'Fontweight','bold');
ylabel('Accuracy [%]', 'Fontsize',8, 'Fontweight','bold');



img = gcf();
imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\accBars.tiff');
print(img,imgname, '-dtiff', '-r800') 
