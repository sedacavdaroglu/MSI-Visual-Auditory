function CongruencyAnalysis()

%Compares the accuracy for trials where total duration and frequency is
%congruent with numerosity and not.

%Author: Seda Cavdaroglu
%Date: 18.09.2014
subNo = [2,3,4,6,7,8,9,10,11,12,13,14,15,16,18,19];
% subNo = [4,6,7,8,9,10,11,12,13,14,18,19];

B = [5,6,7,8,9,11,13,15,17,20];
type = 2;%1= linear, 2 = log scale

data_aud = zeros(length(subNo),176);
data_vis = zeros(length(subNo),176);
data_sim = zeros(length(subNo),176);

dur_cong_aud = zeros(length(subNo),176);
dur_cong_vis = zeros(length(subNo),176);
dur_cong_sim = zeros(length(subNo),176);


freq_aud_num = zeros(length(subNo),176);
freq_vis_num = zeros(length(subNo),176);
freq_sim_num = zeros(length(subNo),176);



freq_aud_prob = zeros(length(subNo),176);
freq_vis_prob = zeros(length(subNo),176);
freq_sim_prob = zeros(length(subNo),176);


freq_cong_aud = zeros(length(subNo),176);
freq_cong_vis = zeros(length(subNo),176);
freq_cong_sim = zeros(length(subNo),176);

%the accuracy for congruent trials in duration in each subject
acc_aud_dur_cong = zeros(length(subNo),1);
acc_vis_dur_cong = zeros(length(subNo),1);
acc_sim_dur_cong = zeros(length(subNo),1);

%the accuracy for incongruent trials in duration in each subject
acc_aud_dur_incong = zeros(length(subNo),1);
acc_vis_dur_incong = zeros(length(subNo),1);
acc_sim_dur_incong = zeros(length(subNo),1);


%the accuracy for congruent trials in frequency in each subject
acc_aud_freq_cong = zeros(length(subNo),1);
acc_vis_freq_cong = zeros(length(subNo),1);
acc_sim_freq_cong = zeros(length(subNo),1);

%the accuracy for incongruent trials in frequency in each subject
acc_aud_freq_incong = zeros(length(subNo),1);
acc_vis_freq_incong = zeros(length(subNo),1);
acc_sim_freq_incong = zeros(length(subNo),1);


for s = 1:length(subNo)
    
    %open the text file to read the output
    
    subj_file_vis = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\visualDany\log_files\subject_',num2str(subNo(s)),'_WFlog.txt');
    subj_file_aud = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\auditoryDany\log_files\subject_',num2str(subNo(s)),'_WFlog.txt');
    subj_file_sim = strcat('C:\Users\cavdaros\Desktop\MultiSensory_Final\simultaneousDany\log_files\subject_',num2str(subNo(s)),'_WFlog.txt');
    
    
    fid_aud = fopen(subj_file_aud);
    A_aud = fscanf(fid_aud, '%c %c', [1 114]);
    A_aud = fscanf(fid_aud, '%f %f', [14 inf]);
    A_aud = A_aud';
    fclose(fid_aud);
    
    fid_vis = fopen(subj_file_vis);
    A_vis = fscanf(fid_vis, '%c %c', [1 114]);
    A_vis = fscanf(fid_vis, '%f %f', [14 inf]);
    A_vis = A_vis';
    fclose(fid_vis);
    
    
    fid_sim = fopen(subj_file_sim);
    A_sim = fscanf(fid_sim, '%c %c', [1 114]);
    A_sim = fscanf(fid_sim, '%f %f', [14 inf]);
    A_sim = A_sim';
    fclose(fid_sim);
    
    
    %some temporary variables to calculate accuracy
    total_aud_dur_cong = 0;
    total_vis_dur_cong = 0;
    total_sim_dur_cong = 0;
    corr_aud_dur_cong = 0;
    corr_vis_dur_cong = 0;
    corr_sim_dur_cong = 0;
    total_aud_dur_incong = 0;
    total_vis_dur_incong = 0;
    total_sim_dur_incong = 0;
    corr_aud_dur_incong = 0;
    corr_vis_dur_incong = 0;
    corr_sim_dur_incong = 0;
    total_aud_freq_cong = 0;
    total_vis_freq_cong = 0;
    total_sim_freq_cong = 0;
    corr_aud_freq_cong = 0;
    corr_vis_freq_cong = 0;
    corr_sim_freq_cong = 0;
    total_aud_freq_incong = 0;
    total_vis_freq_incong = 0;
    total_sim_freq_incong = 0;
    corr_aud_freq_incong = 0;
    corr_vis_freq_incong = 0;
    corr_sim_freq_incong = 0;
    
    
    
    for i = 1:176
        %record if the answer is correct or not
        data_aud(s,i) = A_aud(i,14);
        data_vis(s,i) = A_vis(i,14);
        data_sim(s,i) = A_sim(i,14);
        
        
        freq_aud_num(s,i) = A_aud(i,4)/A_aud(i,10);
        freq_vis_num(s,i) = A_vis(i,4)/A_sim(i,10);
        freq_sim_num(s,i) = A_sim(i,4)/A_vis(i,10);
        
        
        freq_aud_prob(s,i) = 10/A_aud(i,11);
        freq_vis_prob(s,i) = 10/A_sim(i,11);
        freq_sim_prob(s,i) = 10/A_vis(i,11);
        
        %check the congruency of number with duration
        if A_aud(i,4) < 10 && A_aud(i,10) < A_aud(i,11)
            dur_cong_aud(s,i) = 1;
        elseif A_aud(i,4) > 10 && A_aud(i,10) > A_aud(i,11)
            dur_cong_aud(s,i) = 1;
        else
            dur_cong_aud(s,i) = 0;
        end;
        
        
        if A_vis(i,4) < 10 && A_vis(i,10) < A_vis(i,11)
            dur_cong_vis(s,i) = 1;
        elseif A_vis(i,4) > 10 && A_vis(i,10) > A_vis(i,11)
            dur_cong_vis(s,i) = 1;
        else
            dur_cong_vis(s,i) = 0;
        end;
        
        
        if A_sim(i,4) < 10 && A_sim(i,10) < A_sim(i,11)
            dur_cong_sim(s,i) = 1;
        elseif A_sim(i,4) > 10 && A_sim(i,10) > A_sim(i,11)
            dur_cong_sim(s,i) = 1;
        else
            dur_cong_sim(s,i) = 0;
        end;
        
        
        
        %check the congruency of frequency with number
        if A_aud(i,4) < 10 && freq_aud_num(s,i) < freq_aud_prob(s,i)
            freq_cong_aud(s,i) = 1;
        elseif A_aud(i,4) > 10 && freq_aud_num(s,i) > freq_aud_prob(s,i)
            freq_cong_aud(s,i) = 1;
        else
            freq_cong_aud(s,i) = 0;
        end;
        
        
        if A_vis(i,4) < 10 && freq_vis_num(s,i) < freq_vis_prob(s,i)
            freq_cong_vis(s,i) = 1;
        elseif A_vis(i,4) > 10 && freq_vis_num(s,i) > freq_vis_prob(s,i)
            freq_cong_vis(s,i) = 1;
        else
            freq_cong_vis(s,i) = 0;
        end;
        
        
        if A_sim(i,4) < 10 && freq_sim_num(s,i) < freq_sim_prob(s,i)
            freq_cong_sim(s,i) = 1;
        elseif A_sim(i,4) > 10 && freq_sim_num(s,i) > freq_sim_prob(s,i)
            freq_cong_sim(s,i) = 1;
        else
            freq_cong_sim(s,i) = 0;
        end;
        
        %calculate the accuracy for incongurent and congruent trials
        %separately based on duration
        if(data_aud(s,i) == 1)
            if (dur_cong_aud(s,i) == 1)
                corr_aud_dur_cong = corr_aud_dur_cong + 1;
                total_aud_dur_cong = total_aud_dur_cong + 1;
            else
                corr_aud_dur_incong = corr_aud_dur_incong + 1;
                total_aud_dur_incong = total_aud_dur_incong + 1;
            end;
            
        elseif(data_aud(s,i) == 0)
            if (dur_cong_aud(s,i) == 1)
                total_aud_dur_cong = total_aud_dur_cong + 1;
            else
                total_aud_dur_incong = total_aud_dur_incong + 1;
            end;
        end;
        
        
        if(data_vis(s,i) == 1)
            if (dur_cong_vis(s,i) == 1)
                corr_vis_dur_cong = corr_vis_dur_cong + 1;
                total_vis_dur_cong = total_vis_dur_cong + 1;
            else
                corr_vis_dur_incong = corr_vis_dur_incong + 1;
                total_vis_dur_incong = total_vis_dur_incong + 1;
            end;
            
        elseif(data_vis(s,i) == 0)
            if (dur_cong_vis(s,i) == 1)
                total_vis_dur_cong = total_vis_dur_cong + 1;
            else
                total_vis_dur_incong = total_vis_dur_incong + 1;
            end;
        end;
        
        
        if(data_sim(s,i) == 1)
            if (dur_cong_sim(s,i) == 1)
                corr_sim_dur_cong = corr_sim_dur_cong + 1;
                total_sim_dur_cong = total_sim_dur_cong + 1;
            else
                corr_sim_dur_incong = corr_sim_dur_incong + 1;
                total_sim_dur_incong = total_sim_dur_incong + 1;
            end;
            
        elseif(data_sim(s,i) == 0)
            if (dur_cong_sim(s,i) == 1)
                total_sim_dur_cong = total_sim_dur_cong + 1;
            else
                total_sim_dur_incong = total_sim_dur_incong + 1;
            end;
        end;
        
        %calculate the accuracy for incongurent and congruent trials
        %separately based on frequency
        if(data_aud(s,i) == 1)
            if (freq_cong_aud(s,i) == 1)
                corr_aud_freq_cong = corr_aud_freq_cong + 1;
                total_aud_freq_cong = total_aud_freq_cong + 1;
            else
                corr_aud_freq_incong = corr_aud_freq_incong + 1;
                total_aud_freq_incong = total_aud_freq_incong + 1;
            end;
            
        elseif(data_aud(s,i) == 0)
            if (freq_cong_aud(s,i) == 1)
                total_aud_freq_cong = total_aud_freq_cong + 1;
            else
                total_aud_freq_incong = total_aud_freq_incong + 1;
            end;
        end;
        
        
        if(data_vis(s,i) == 1)
            if (freq_cong_vis(s,i) == 1)
                corr_vis_freq_cong = corr_vis_freq_cong + 1;
                total_vis_freq_cong = total_vis_freq_cong + 1;
            else
                corr_vis_freq_incong = corr_vis_freq_incong + 1;
                total_vis_freq_incong = total_vis_freq_incong + 1;
            end;
            
        elseif(data_vis(s,i) == 0)
            if (freq_cong_vis(s,i) == 1)
                total_vis_freq_cong = total_vis_freq_cong + 1;
            else
                total_vis_freq_incong = total_vis_freq_incong + 1;
            end;
        end;
        
        
        if(data_sim(s,i) == 1)
            if (freq_cong_sim(s,i) == 1)
                corr_sim_freq_cong = corr_sim_freq_cong + 1;
                total_sim_freq_cong = total_sim_freq_cong + 1;
            else
                corr_sim_freq_incong = corr_sim_freq_incong + 1;
                total_sim_freq_incong = total_sim_freq_incong + 1;
            end;
            
        elseif(data_sim(s,i) == 0)
            if (freq_cong_sim(s,i) == 1)
                total_sim_freq_cong = total_sim_freq_cong + 1;
            else
                total_sim_freq_incong = total_sim_freq_incong + 1;
            end;
        end;
        


        
        
    end;
    acc_aud_dur_cong(s,1) = corr_aud_dur_cong/total_aud_dur_cong;
    acc_vis_dur_cong(s,1) = corr_vis_dur_cong/total_vis_dur_cong;
    acc_sim_dur_cong(s,1) = corr_sim_dur_cong/total_sim_dur_cong;
    
    
    acc_aud_dur_incong(s,1) = corr_aud_dur_incong/total_aud_dur_incong;
    acc_vis_dur_incong(s,1) = corr_vis_dur_incong/total_vis_dur_incong;
    acc_sim_dur_incong(s,1) = corr_sim_dur_incong/total_sim_dur_incong;
    
    
    
    acc_aud_freq_cong(s,1) = corr_aud_freq_cong/total_aud_freq_cong;
    acc_vis_freq_cong(s,1) = corr_vis_freq_cong/total_vis_freq_cong;
    acc_sim_freq_cong(s,1) = corr_sim_freq_cong/total_sim_freq_cong;
    
    
    acc_aud_freq_incong(s,1) = corr_aud_freq_incong/total_aud_freq_incong;
    acc_vis_freq_incong(s,1) = corr_vis_freq_incong/total_vis_freq_incong;
    acc_sim_freq_incong(s,1) = corr_sim_freq_incong/total_sim_freq_incong;


end

% disp(acc_aud_dur_cong);
% disp(acc_vis_dur_cong);
% disp(acc_sim_dur_cong);
% disp(acc_aud_dur_incong);
% disp(acc_vis_dur_incong);
% disp(acc_sim_dur_incong);
% 
% 
% disp(acc_aud_freq_cong);
% disp(acc_vis_freq_cong);
% disp(acc_sim_freq_cong);
% disp(acc_aud_freq_incong);
% disp(acc_vis_freq_incong);
% disp(acc_sim_freq_incong);


%compare the accuracy for congurent and incongruent trials over all
%subjects
disp('Auditory duration congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_aud_dur_cong,acc_aud_dur_incong);
disp(P);
disp(mean(acc_aud_dur_cong));
disp(mean(acc_aud_dur_incong));
[H,P,CI,STATS] = ttest(acc_aud_dur_incong,0.50);
disp(STATS);
disp(P);
disp('Visual duration congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_vis_dur_cong,acc_vis_dur_incong);
disp(P);
disp(mean(acc_vis_dur_cong));
disp(mean(acc_vis_dur_incong));
[H,P,CI,STATS] = ttest(acc_vis_dur_incong,0.5);
disp(STATS);
disp(P);
disp('Simultaneous duration congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_sim_dur_cong,acc_sim_dur_incong);
disp(P);
disp(mean(acc_sim_dur_cong));
disp(mean(acc_sim_dur_incong));
[H,P,CI,STATS] = ttest(acc_sim_dur_incong,0.5);
disp(STATS);
disp(P);


disp('Auditory frequency congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_aud_freq_cong,acc_aud_freq_incong);
disp(P);
disp(mean(acc_aud_freq_cong));
disp(mean(acc_aud_freq_incong));
[H,P,CI,STATS] = ttest(acc_aud_freq_incong,0.5);
disp(STATS);
disp(P);
disp('Visual frequency congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_vis_freq_cong,acc_vis_freq_incong);
disp(P);
disp(mean(acc_vis_freq_cong));
disp(mean(acc_vis_freq_incong));
[H,P,CI,STATS] = ttest(acc_vis_freq_incong,0.50);
disp(STATS);
disp(P);
disp('Simultaneous frequency congruent vs incongruent:')
[H,P,CI,STATS] = ttest(acc_sim_freq_cong,acc_sim_freq_incong);
disp(P);
disp(mean(acc_sim_freq_cong));
disp(mean(acc_sim_freq_incong));
[H,P,CI,STATS] = ttest(acc_sim_freq_incong,0.50);
disp(STATS);
disp(P);



%Draw lines for congruent and incongruent trials in duration
%accuracy for congruent and incongruent trials with duration and freq
acc_dur_aud = [mean(acc_aud_dur_cong),mean(acc_aud_dur_incong)];
sem_dur_aud = [std(acc_aud_dur_cong)/sqrt(length(subNo)),std(acc_aud_dur_incong)/sqrt(length(subNo))];
acc_dur_vis = [mean(acc_vis_dur_cong),mean(acc_vis_dur_incong)];
sem_dur_vis = [std(acc_vis_dur_cong)/sqrt(length(subNo)),std(acc_vis_dur_incong)/sqrt(length(subNo))];
acc_dur_sim = [mean(acc_sim_dur_cong),mean(acc_sim_dur_incong)];
sem_dur_sim = [std(acc_sim_dur_cong)/sqrt(length(subNo)),std(acc_sim_dur_incong)/sqrt(length(subNo))];

mFigure = figure('Color',[1 1 1]);
set(gcf,'numbertitle','off','name','Accuracy') %change the title of the figure
plot([acc_dur_vis],'r');
title('Duration');
hold on;
plot(acc_dur_aud,'b');
hold on;
plot(acc_dur_sim,'k');
hold on;


h = legend('visual','auditory','multimodal','Location',[0.82,0.8,0.005,0.005]);
set(h,'PlotBoxAspectRatioMode','manual');
set(h,'PlotBoxAspectRatio',[1 0.5 1]);
legend(h,'boxoff');

box off;

colorOfFigureWindow = get(mFigure,'Color');
h = annotation('textbox',[0.01 0.85 0.05 0.15],'String','a','FontSize',8,'Fontweight','bold','BackgroundColor',colorOfFigureWindow,'EdgeColor','none');


set(gcf,'PaperUnits','centimeters');
xSize = 6; ySize =3.6;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);
xlim([0.5 2.5]);

set(gca,'FontSize',8, 'XTick',[1 2],'XTickLabel', {'congruent','incongruent'});
xlabel('Modality', 'Fontsize',8, 'Fontweight','bold');
ylabel('Accuracy [%]', 'Fontsize',8, 'Fontweight','bold');


img = gcf();
imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\congruencyDur.tiff');
print(img,imgname, '-dtiff', '-r800') 


%%
%Draw lines for congruent and incongruent trials in frequency
%accuracy for congruent and incongruent trials with frequency and freq
acc_freq_aud = [mean(acc_aud_freq_cong),mean(acc_aud_freq_incong)];
sem_freq_aud = [std(acc_aud_freq_cong)/sqrt(length(subNo)),std(acc_aud_freq_incong)/sqrt(length(subNo))];
acc_freq_vis = [mean(acc_vis_freq_cong),mean(acc_vis_freq_incong)];
sem_freq_vis = [std(acc_vis_freq_cong)/sqrt(length(subNo)),std(acc_vis_freq_incong)/sqrt(length(subNo))];
acc_freq_sim = [mean(acc_sim_freq_cong),mean(acc_sim_freq_incong)];
sem_freq_sim = [std(acc_sim_freq_cong)/sqrt(length(subNo)),std(acc_sim_freq_incong)/sqrt(length(subNo))];
 
mFigure = figure('Color',[1 1 1]);
set(gcf,'numbertitle','off','name','Frequency') %change the title of the figure
plot([acc_freq_vis],'r');
title('Frequency');
hold on;
plot(acc_freq_aud,'b');
hold on;
plot(acc_freq_sim,'k');
hold on;
 
 
h = legend('visual','auditory','multimodal','Location',[0.82,0.8,0.005,0.005]);
set(h,'PlotBoxAspectRatioMode','manual');
set(h,'PlotBoxAspectRatio',[1 0.5 1]);
legend(h,'boxoff');
 
box off;

colorOfFigureWindow = get(mFigure,'Color');
h = annotation('textbox',[0.01 0.85 0.05 0.15],'String','b','FontSize',8,'Fontweight','bold','BackgroundColor',colorOfFigureWindow,'EdgeColor','none');

set(gcf,'PaperUnits','centimeters');
xSize = 6; ySize =3.6;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize]);
set(gcf,'Position',[.5 .5 xSize*50 ySize*50]);
xlim([0.5 2.5]);
 
set(gca,'FontSize',8, 'XTick',[1 2],'XTickLabel', {'congruent','incongruent'});
xlabel('Modality', 'Fontsize',8, 'Fontweight','bold');
ylabel('Accuracy [%]', 'Fontsize',8, 'Fontweight','bold');
 
 
img = gcf();
imgname = strcat('C:\Users\cavdaros\Desktop\msi paper\congruencyFreq.tiff');
print(img,imgname, '-dtiff', '-r800') 

