function [durs,ints]= Vis_GetDursInt(num,set)

%initialize arrays & other parameters
durations = zeros(num,1);
intervals = zeros(num-1,1);


durs = [0.07,0.07,0.085,0.085,0.085,0.1,0.1,0.1,0.2,0.2,0.2;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.6,0.5,0.4,0.32,0.28,0.24,0.21,0.16,0.13,0.1,0.07];
ints = [0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.07,0.07,0.09,0.09,0.09,0.18,0.18,0.18,0.25,0.25,0.25;
        0.25,0.23,0.2,0.19,0.18,0.1,0.095,0.09,0.076,0.075,0.07;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07];
    
    
nums = [5 6 7 8 9 10 11 13 15 17 20];

indx = find(num == nums);

a = randperm(num);
if 5 <= num <= 8
    size = 2;
    jitArray = [1,-1];
    jitArray = Shuffle(jitArray);
elseif 9 <= num <= 13
    size = 4;
    jitArray = [1,1,-1,-1];
    jitArray = Shuffle(jitArray);
elseif num == 20
    size = 6;
    jitArray = [1,1,1,-1,-1,-1];
    jitArray = Shuffle(jitArray);
end;
jitCount = 1; %counts the number of jitters already put


disp(num);

b = zeros(size,1);
for k = 1:size
    b(k,1) = a(k);
end;

for z = 1:num
    if ~ismember(z,b) && z ~= num
        durations(z,1) = durs(set,indx);
        intervals(z,1) = ints(set,indx);
    elseif ~ismember(z,b) && z == num
        durations(z,1) = durs(set,indx);
        intervals(z-1,1) = ints(set,indx);
    elseif ismember(z,b) && z ~= num
        durJit = durs(set,indx)-0.04;
        isiJit = ints(set,indx) -0.04;
        durations(z,1)= durs(set,indx)+jitArray(jitCount)*durJit;
        intervals(z,1) = ints(set,indx)-jitArray(jitCount)*isiJit;
        jitCount = jitCount + 1;
    else
        durJit = durs(set,indx)-0.04;
        isiJit = ints(set,indx) -0.04;
        durations(z,1) = durs(set,indx)+jitArray(jitCount)*durJit;
        intervals(z-1,1) = ints(set,indx)-jitArray(jitCount)*isiJit;
        jitCount = jitCount + 1;
    end;
end;

durs = durations;
ints = intervals;