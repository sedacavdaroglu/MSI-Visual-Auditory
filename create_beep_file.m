function create_beep_file(specs,fileName)
%BEEP_SERIES  Create a series of beeps
%    BEEP_SERIES([FREQ_HZ, VOL, DUR_SEC, PAUSE_SEC]) creates a series of
%    beeps from an N-by-3 spec matrix, where the colums represent:
%        frequency
%        volumne (0-1)
%        beep duration
%        pause duration,

freq = specs(:,1);
duration = specs(:,2);
trailingGap = specs(:,3);

onset = 0.2;
offset = 0.2;

SAMPLE_FREQ = 44100;%8192;
totalTime = onset + sum(duration) + sum(trailingGap) + offset;
x = zeros(ceil(totalTime*SAMPLE_FREQ),2);
%disp(length(x));

curBeepStartTime = onset;
for ix = 1:length(freq)
    
   t = 0:(1/SAMPLE_FREQ):duration(ix);
    numSamples = round(duration(ix)*SAMPLE_FREQ);
    if length(round(curBeepStartTime*SAMPLE_FREQ + (1:numSamples))) == length(sin(2*pi*freq(ix)*t))
        add = 0;
    else
        add = 1;
    end;
    
    ramp_dur=0.1*duration(ix); %in proportion to total stim duration
    stim_length= numSamples+add;
    ramp_length=ceil(ramp_dur*SAMPLE_FREQ);
    
    % create ramp
    ramp=[fliplr(.5*cos(linspace(0,pi,ramp_length))+.5),ones(1,stim_length-2*ramp_length),(.5*cos(linspace(0,pi,ramp_length))+.5)];
% 
%     x( round(curBeepStartTime*SAMPLE_FREQ + (1:numSamples+add)),2) = ...   
%         ramp.*sin(2*pi*freq(ix)*t);
    x( round(curBeepStartTime*SAMPLE_FREQ + (1:numSamples+add)),1) = ...   
        ramp.*sin(2*pi*freq(ix)*t);
%     x( round(curBeepStartTime*SAMPLE_FREQ + (1:numSamples+add)),2) = ...   
%         ramp.*sin(2*pi*freq(ix)*t);
        %volume(ix)*sin(linspace(0, duration(ix)*freq(ix)*2*pi, round(duration(ix)*SAMPLE_FREQ)));
        %volume(ix) * sin(    (1:numSamples)  *  (2*pi*freq(ix)/SAMPLE_FREQ)   );%volume(ix)*sin(2*pi*freq(ix)*t);
    curBeepStartTime = curBeepStartTime + duration(ix) + trailingGap(ix);
end


% Fs = 20000; % Hz - Signal Frequency
% Fc = 20*Fs; % Hz - Samplying Frequency
% T = 1/Fs; % Signal Period
% totalTime = onset + sum(duration) + sum(trailingGap) + offset;
% x = zeros(ceil(totalTime*Fs),1);
% 
% 
% curBeepStartTime = onset;
% for ix = 1:length(freq)
%     N = duration(ix)*Fs; 
%     t = linspace(0, T*N , N*T*Fc);
%     y = sin(2*pi*t/T);
%     numSamples = round(duration(ix)*Fs);
% %     disp(length(sin(2*pi*freq(ix)*t)));
%     %x( round(curBeepStartTime*SAMPLE_FREQ + (1:numSamples+add)),2) = 0;
%     a = round(curBeepStartTime*Fs + (1:N));
%     x( round(curBeepStartTime*Fs + (1:N)),1) = y;
%         %volume(ix)*sin(linspace(0, duration(ix)*freq(ix)*2*pi, round(duration(ix)*SAMPLE_FREQ)));
%         %volume(ix) * sin(    (1:numSamples)  *  (2*pi*freq(ix)/SAMPLE_FREQ)   );%volume(ix)*sin(2*pi*freq(ix)*t);
%     curBeepStartTime = curBeepStartTime + duration(ix) + trailingGap(ix);
% end

n=40;
Wn1=19999*2/SAMPLE_FREQ;
Wn2=20001*2/SAMPLE_FREQ;
Wn = [Wn1 Wn2];
[b a]=butter(n,Wn,'bandpass');
% Apply the filter to the data
datafilt=filter(b,a,x);

wavwrite(x,SAMPLE_FREQ,32,fileName);
%a = wavread(fileName);
%wavplay(a,SAMPLE_FREQ);
%sound(x, SAMPLE_FREQ);
