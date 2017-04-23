fs=44100;
stim_dur=1; % in seconds
ramp_dur=0.1; %in proportion to total stim duration
stim_length=ceil(stim_dur*fs);
ramp_length=ceil(ramp_dur*fs);

% create ramp
ramp=[fliplr(.5*cos(linspace(0,pi,ramp_length))+.5),ones(1,stim_length-2*ramp_length),(.5*cos(linspace(0,pi,ramp_length))+.5)];

% then you just generate the stimulus that you want to ramp on and off (here white noise)
stim=randn(1,stim_length);

% and apply the ramp
stim=stim.*ramp;