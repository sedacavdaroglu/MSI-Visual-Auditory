function create_sound_files()

%author: Seda Cavdaroglu, 15/08/13


%sound parameter
%Fs = 9000;      %# Samples per second
toneFreq = 20000;  %# Tone frequency, in Hertz
%vol = 1;

%get the durations, intervals and the order of numbers to be used
[durs1,ints1,numbers,set_info] = CreateSequence();
durs2 = durs1;
ints2 = ints1;
while isequal(durs2,durs1) 
    [durs2,ints2,numbers,set_info] = CreateSequence();
end;
durs3 = durs2;
while isequal(durs2,durs3) || isequal(durs1,durs3)
    [durs3,ints3,numbers,set_info] = CreateSequence();
end;
durs4 = durs3;
while isequal(durs1,durs4) || isequal(durs2,durs4) || isequal(durs3,durs4)
    [durs4,ints4,numbers,set_info] = CreateSequence();
end;

for i = 1:length(numbers)
    
    specs = zeros(numbers(i),3);
    for j = 1:numbers(i)
        
        specs(j,1) = toneFreq;                      
        specs(j,2) = durs1(j,i);
        if j ~= numbers(i)
            specs(j,3) = ints1(j,i);
        end;
    end;
    fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(numbers(i)),'_set_',int2str(set_info(i)),'_1.wav');
    create_beep_file(specs,fileName);
    
    
    for j = 1:numbers(i)
        
        specs(j,1) = toneFreq;                      
        specs(j,2) = durs2(j,i);
        if j ~= numbers(i)
            specs(j,3) = ints2(j,i);
        end;
    end;
    fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(numbers(i)),'_set_',int2str(set_info(i)),'_2.wav');
    create_beep_file(specs,fileName);
    
    
    
    for j = 1:numbers(i)
        
        specs(j,1) = toneFreq;                      
        specs(j,2) = durs3(j,i);
        if j ~= numbers(i)
            specs(j,3) = ints3(j,i);
        end;
    end;
    fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(numbers(i)),'_set_',int2str(set_info(i)),'_3.wav');
    create_beep_file(specs,fileName);
    
    
    
    for j = 1:numbers(i)
        
        specs(j,1) = toneFreq;                      
        specs(j,2) = durs4(j,i);
        if j ~= numbers(i)
            specs(j,3) = ints4(j,i);
        end;
    end;
    fileName = strcat('/home/user/project2/Psychophysics/MultiSensory/visual/sound_files/number_',int2str(numbers(i)),'_set_',int2str(set_info(i)),'_4.wav');
    create_beep_file(specs,fileName);
    
end;

save parameters.mat
save durs1 ints1 durs2 ints2 durs3 ints3 durs4 ints4
%end;