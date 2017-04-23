function MultiSens()
 
%This function finds the weber fraction
%of numerosity discrimination in visual domain
%using method of constant stimuli

%Author: Seda Cavdaroglu
%Date: 06.09.2013

 
%numbers
ns = [5 6 7 8 9 11 13 15 17 20];
refNum = 10; %the reference number to be compared
repsPerNum = [12 12 20 20 24 24 20 20 12 12];
sets1 = [1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;];
sets2 = [1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;
    1,2,3,4,1,2,3,4,1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0;];
sets1(1,:) = Shuffle(sets1(1,:));
sets1(2,:) = Shuffle(sets1(2,:));
sets1(3,:) = Shuffle(sets1(3,:));
sets1(4,:) = Shuffle(sets1(4,:));
sets1(5,:) = Shuffle(sets1(5,:));
sets1(6,:) = Shuffle(sets1(6,:));
sets1(7,:) = Shuffle(sets1(7,:));
sets1(8,:) = Shuffle(sets1(8,:));
sets1(9,:) = Shuffle(sets1(9,:));
sets1(10,:) = Shuffle(sets1(10,:));

sets2(1,:) = Shuffle(sets2(1,:));
sets2(2,:) = Shuffle(sets2(2,:));
sets2(3,:) = Shuffle(sets2(3,:));
sets2(4,:) = Shuffle(sets2(4,:));
sets2(5,:) = Shuffle(sets2(5,:));
sets2(6,:) = Shuffle(sets2(6,:));
sets2(7,:) = Shuffle(sets2(7,:));
sets2(8,:) = Shuffle(sets2(8,:));
sets2(9,:) = Shuffle(sets2(9,:));
sets2(10,:) = Shuffle(sets2(10,:));

counterOfSets1 = zeros(10,1);
counterOfSets2 = zeros(10,1);
totalReps = sum(repsPerNum);
refNumSets1 = 1:1:totalReps;
refNumSets2 = 1:1:totalReps;
refNumSets1 = Shuffle(refNumSets1);
refNumSets2 = Shuffle(refNumSets2);

nums = zeros(totalReps,1);
answers = zeros(totalReps,1);%records if the subject answered correctly or not


%create an array of ones and zeros to randomly determine if the correct 
%answer will be the first in the series or second
order1 = ones(totalReps/2,1);
order2 = zeros(totalReps/2,1);
order = [order1;order2];
order = Shuffle(order);

tmp = 1;
for i = 1:length(ns)
    for j = tmp:(tmp+repsPerNum(i)-1)
        nums(j,1) = ns(i);
    end;
    tmp = tmp + repsPerNum(i);
end;


nums = Shuffle(nums);



%get subject number before starting the task
prompt = {'Subject Number:'};
dlg_title = 'Subject Information';
num_lines = 1;
def = {'',''};
answer = inputdlg(prompt,dlg_title,num_lines,def);
subNo =str2num(char(answer(1)));

%open the text file to write the output
%subj_file = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/log_files/subject_',num2str(subNo),'_WFlog.txt');
%fid = fopen(subj_file,'at');
%subj_resp_file = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/log_files/vis_subject_',num2str(subNo),'.txt');
%fid2 = fopen(subj_resp_file,'at');
subj_file = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/log_files/subject_',num2str(subNo),'_WFlog.txt');
fid = fopen(subj_file,'at');
subj_resp_file = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/log_files/vis_subject_',num2str(subNo),'.txt');
fid2 = fopen(subj_resp_file,'at');



%define colors
black = [0 0 0];
red = [255 0 0];
blue = [0 0 255];
white = [255 255 255];
green = [0 255 0];

%create the screen
screens=Screen('Screens');
screenNumber=max(screens);
[w, rect] = Screen('OpenWindow', screenNumber, black);



HideCursor;	% Hide the mouse cursor
Priority(MaxPriority(w));



kc_esc = KbName('Escape');
modality = 1; % 1   = visual

%screen parameters
% Do initial flip...
Screen('Flip',w);
[center(1), center(2)] = RectCenter(rect);

%use the s char to start the task
kc_space = KbName('space');
kc_lctrl = KbName('Control_L');
kc_rctrl = KbName('Control_R');

%bell ring sound
%bellFile = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/bell.wav');
bellFile = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/bell_1_5sec.wav');
%answerBell = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/answer_bell.wav');

silence = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/silence.wav');


%wait for a key press (space bar) to start the experiment
[keyIsDown secs keycodes] = KbCheck();
while isempty(keycodes) || ~keycodes(kc_space)
    Screen('DrawText', w, 'Druecken Sie die Leertaste, um mit dem Experiment zu starten...', center(1)-450, center(2),white);
    Screen('Flip', w);
    [keyIsDown secs keycodes] = KbCheck();
end;
expTimer = tic();

% %write the title into the output file
output_list = {'subject','trial_no','type','number','ref_number','set1','set2','prob_set1','prob_set2','num_dur','prob_dur','corr_ans','sub_ans','sub_ans_corr_or_not'};
for z = 1:length(output_list)
    fprintf(fid,'%s\t',output_list{z});
end;
%jump to the next line in the output file
fprintf(fid,'%s\n','');
 

%[durs,ints,nos,set_info] = create_sound_files();
load parameters.mat


[y, Fs] = audioread(bellFile);
y1 = 10.*y(:,2);
y2 = 0.*y(:,2);
y3 = [y2 y1];
p1 = audioplayer(y3,Fs);


[y, Fs] = audioread(bellFile);
y1 = 10.*y(:,2);
y2 = 0.*y(:,2); 
y3 = [y2 y1];
p2 = audioplayer(y3,Fs);

%This is the new code from dany to add silence code
[y, Fs] = audioread(silence);
y1 = 10.*y(:,2);
y2 = 0.*y(:,2); 
y3 = [y2 y1];
pSilence = audioplayer(y3,Fs);


for i = 1:totalReps

    %initial space for 0.2 secs
    t0 = timer('TimerFcn', 'stat=false','StartDelay',0.2);
    start(t0);
    while(strcmp(get(t0,'Running'),'on'))
        Screen('Flip', w);
    end;  
    
    index = find(nums(i)==ns);
    counterOfSets1(index,1) = counterOfSets1(index,1) + 1;
    counterOfSets2(index,1) = counterOfSets2(index,1) + 1;

    while sets1(index,counterOfSets1(index,1)) == 0
        counterOfSets1(index,1) = counterOfSets1(index,1) + 1;
    end;
    while sets2(index,counterOfSets2(index,1)) == 0
        counterOfSets2(index,1) = counterOfSets2(index,1) + 1;
    end;

    
    %display the larger number first
    if order(i) == 0
        
        
        
        if nums(i) > refNum        
            %fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            %fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
            fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
        else
            %fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            %fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
            fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
        end    
        %end    
            
        
        [y, Fs] = audioread(fileName);
        p3 = audioplayer(y,Fs);
        
        [y, Fs] = audioread(bellFile);
        y1 = 10.*y(:,2);
        p4 = audioplayer(y1,Fs);
        
        
        playblocking(p1);%wavplay(y1,Fs,'async') ;
        pause(0.2);
        
        % The following lines of code are necessary for PsychPortAudio's handling of the wav file.
%         MySongData = MySongFile';
%         Channels = size(MySongData,1);          % Number of rows == number of channels.
%         
%         % Performing a basic initialization of the sound driver
%         InitializePsychSound;
%         
%         
%         MySongHandle = PsychPortAudio('Open', [], [], 0, MySongFreq, Channels);
%         
%         % Fill the audio playback buffer with the audio data
%         PsychPortAudio('FillBuffer', MySongHandle, MySongData);
        
        t_start = tic();
        playblocking(p3);
        if nums(i) >refNum
            num_dur = toc(t_start);
        else
            refnum_dur = toc(t_start);
        end
        
%         StartMusic = PsychPortAudio('Start', MySongHandle, 1, 0, 1);
%         
%         status = PsychPortAudio('GetStatus', MySongHandle);
%         while status.Active
%             status = PsychPortAudio('GetStatus', MySongHandle);
%         end;
        
        % To end your audio playback at some later point in the script
% 
%         PsychPortAudio('Stop', MySongHandle);
%         PsychPortAudio('Close', MySongHandle);

        playblocking(pSilence);
        pause(0.2);
        
        
        %play the second sound-reference sound
        [y, Fs] = audioread(fileName2);
        p = audioplayer(y,Fs);
        
        % The following lines of code are necessary for PsychPortAudio's handling of the wav file.
%         MySongData = MySongFile';
%         Channels = size(MySongData,1);          % Number of rows == number of channels.
%         
%         % Performing a basic initialization of the sound driver
%         InitializePsychSound;
%         
%         
%         MySongHandle = PsychPortAudio('Open', [], [], 0, MySongFreq, Channels);
%         
%         % Fill the audio playback buffer with the audio data
%         PsychPortAudio('FillBuffer', MySongHandle, MySongData);
%         

        t_start = tic();
        playblocking(p);
        if nums(i) >refNum
            refnum_dur = toc(t_start);
        else
            num_dur = toc(t_start);
        end
        
        
%         StartMusic = PsychPortAudio('Start', MySongHandle, 1, 0, 1);
%         
%         
%         status = PsychPortAudio('GetStatus', MySongHandle);
%         while status.Active
%             status = PsychPortAudio('GetStatus', MySongHandle);
%         end;
%         % To end your audio playback at some later point in the script
%         PsychPortAudio('Stop', MySongHandle);
%         refnum_dur = toc(t_start);
%         PsychPortAudio('Close', MySongHandle);

        
        disp(num_dur);
        disp(refnum_dur);
    else

        playblocking(p1);
        pause(0.2);
        
        
        if nums(i) < refNum        
            %fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            %fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
            fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
            
        else
            %fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            %fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
            fileName2 = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(nums(i)),'_set_',int2str(sets1(index,counterOfSets1(index,1))),'_',int2str(sets2(index,counterOfSets2(index,1))),'.wav');
            fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visualDany/sound_files/number_',int2str(refNum),'_set_',int2str(rem(refNumSets1(i),4)+1),'_',int2str(rem(refNumSets2(i),4)+1),'.wav');
        end   
        [y, Fs] = audioread(fileName);        
        p3 = audioplayer(y,Fs);
        
        [y, Fs] = audioread(fileName2);        
        p4 = audioplayer(y,Fs);
        
        
        % The following lines of code are necessary for PsychPortAudio's handling of the wav file.
%         MySongData = MySongFile';
%         Channels = size(MySongData,1);          % Number of rows == number of channels.
%         
%         % Performing a basic initialization of the sound driver
%         InitializePsychSound;
%         
%         
%         MySongHandle = PsychPortAudio('Open', [], [], 0, MySongFreq, Channels);
%         
%         % Fill the audio playback buffer with the audio data
%         PsychPortAudio('FillBuffer', MySongHandle, MySongData);
%         
        
        t_start = tic();
        playblocking(p3);
        if nums(i) < refNum
            num_dur = toc(t_start);
        else
            refnum_dur = toc(t_start);
        end
        
%         StartMusic = PsychPortAudio('Start', MySongHandle, 1, 0, 1);       
%         
%         
%         status = PsychPortAudio('GetStatus', MySongHandle);
%         while status.Active
%             status = PsychPortAudio('GetStatus', MySongHandle);
%         end;
%         
%         
%         % To end your audio playback at some later point in the script
%         PsychPortAudio('Stop', MySongHandle);
%         PsychPortAudio('Close', MySongHandle);
%         refnum_dur = toc(t_start);
%         
        %play the second sound-reference sound
        %[refnum_dur] = beep_series(a2);
        
        
%         % The following lines of code are necessary for PsychPortAudio's handling of the wav file.
%         MySongData = MySongFile';
%         Channels = size(MySongData,1);          % Number of rows == number of channels.
%         
%         % Performing a basic initialization of the sound driver
%         InitializePsychSound;
%         
%         
%         MySongHandle = PsychPortAudio('Open', [], [], 0, MySongFreq, Channels);
%         
%         % Fill the audio playback buffer with the audio data
%         PsychPortAudio('FillBuffer', MySongHandle, MySongData);
        
        
        playblocking(pSilence);
        pause(0.2);
        
        t_start = tic();
        playblocking(p4);
        if nums(i) >refNum
            num_dur = toc(t_start);
        else
            refnum_dur = toc(t_start);
        end
        
%         StartMusic = PsychPortAudio('Start', MySongHandle, 1, 0, 1);
%    
%         
%         status = PsychPortAudio('GetStatus', MySongHandle);
%         while status.Active
%             status = PsychPortAudio('GetStatus', MySongHandle);
%         end;      
%         
%         % To end your audio playback at some later point in the script
%         PsychPortAudio('Stop', MySongHandle);
%         PsychPortAudio('Close', MySongHandle);
%         num_dur = toc(t_start);
%         disp(num_dur);
%         disp(refnum_dur);
    end;
    pause(1);
    playblocking(p2);
    pause(0.2);
    %get the response of the subject
    t1 = timer('TimerFcn', 'stat=false','StartDelay',3);
    start(t1);
    pressed = 0; %parameter to chech if the subject has pressed any buttons or missed the answer

    
    while(strcmp(get(t1,'Running'),'on') && ~pressed)
        % now define a string for each type of key press.
        [keyIsDown secs keycodes] = KbCheck();
        if ~isempty(keycodes)
            if keycodes(kc_esc)
                %fclose(fid);
                Priority(0);
                ShowCursor;
                Screen('CloseAll');
            elseif keycodes(kc_lctrl)
                %subject pressed a button
                pressed = 1;
                sub_ans = 0; % 0 = left, 1 = right
                %if larger number comes first
                if order(i) == 0
                    sub_ans_corr_or_not = 1;
                else %if larger number comes second
                    sub_ans_corr_or_not = 0;
                end;
                
            elseif keycodes(kc_rctrl)
                %subject pressed a button
                pressed = 1;
                sub_ans = 1; % 0 = left, 1 = right
                %if larger number comes first
                if order(i) == 0
                    sub_ans_corr_or_not = 0;  
                else %if larger number comes second
                    sub_ans_corr_or_not = 1;
                end;
            end;
        end;
    end;
    %if the subject did not give any answer, then save it as -1
    if ~pressed
        sub_ans = -1;
        sub_ans_corr_or_not = -1;
    end;
    
    answers(i) = sub_ans_corr_or_not;
    
    
    %write the required parameters into the output file
    %output_list = {'subject','block','trial_no','type','number','ref_number','set1','set2','ref_set1','ref_set2','num_dur','refnum_dur','corr_ans','sub_ans','sub_ans_corr_or_not'};
    output_list = {int2str(subNo),int2str(i),int2str(modality),int2str(nums(i)),int2str(refNum),int2str(sets1(index,counterOfSets1(index,1))),int2str(sets2(index,counterOfSets2(index,1))),int2str(refNumSets1(i)),int2str(refNumSets2(i)),num2str(num_dur,'%.4f'),num2str(refnum_dur,'%.4f'),num2str(order(i),'%.0f'),num2str(sub_ans,'%.0f'),num2str(sub_ans_corr_or_not,'%.0f')};
    %write the output info to the log file
    for z = 1:length(output_list)
        fprintf(fid,'%s\t',output_list{z});
    end;
    %jump to the next line in the output file
    fprintf(fid,'%s\n','');
    
    
    %write the stimuli and the response into the stimuli-response file of
    %the subject, to fit cgf later on
    fprintf(fid2,'%s\t',int2str(nums(i)));
    fprintf(fid2,'%s\n',int2str(answers(i)));
    fprintf(fid2,'%s\r\n','');

    
    t = toc(expTimer);
     %give a break every 10 mins
    if (t>= 600)
        %wait for a key press (space bar) to start the experiment
        [keyIsDown secs keycodes] = KbCheck();
        while isempty(keycodes) || ~keycodes(kc_space)
            Screen('DrawText', w, 'Sie können nun eine Pause machen...', center(1)-450, center(2),white);
            Screen('DrawText', w, 'Druecken Sie die Leertaste, um mit dem Experiment fortzufahren...', center(1)-450, center(2)+50,white);
             Screen('Flip', w);
            [keyIsDown secs keycodes] = KbCheck();
        end;
        expTimer = tic();
    end;
     
end;



fclose(fid2);


%wait for a key press to end the block
[keyIsDown secs keycodes] = KbCheck();
while ~keyIsDown
    [keyIsDown secs keycodes] = KbCheck();
    Screen('DrawText', w, 'Ende des Durchgangs. Dr�cken Sie die Leertaste um zu beenden.', center(1)-400, center(2),white);
    Screen('Flip', w);
end;
%clean the screen
Screen('Flip', w);
Screen('CloseAll');
