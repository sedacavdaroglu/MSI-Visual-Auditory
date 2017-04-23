function [durations,intervals,numbs,set_info]= CreateSequence()

nums = [5 6 7 8 9 10 11 13 15 17 20];

%find out the timing properties of the prob num
% durJit = 0.035; %the jitter to be used on the durations
% isiJit = 0.035; %the jitter to be used on ISI
repsPerBlock = 1;
durations = zeros(20,length(nums)*4*repsPerBlock);
intervals = zeros(19,length(nums)*4*repsPerBlock);
numbs = zeros(20*repsPerBlock,1);
set_info = zeros(20*repsPerBlock,1);



durs = [0.07,0.07,0.085,0.085,0.085,0.1,0.1,0.1,0.2,0.2,0.2;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.6,0.5,0.4,0.32,0.28,0.24,0.21,0.16,0.13,0.1,0.07];
ints = [0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07;
        0.07,0.07,0.09,0.09,0.09,0.18,0.18,0.18,0.25,0.25,0.25;
        0.25,0.23,0.2,0.19,0.18,0.1,0.095,0.09,0.076,0.075,0.07;
        0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07];

for i = 1:length(nums)
    for j = 1:4*repsPerBlock
        set = j;
        set_info((i-1)*4*repsPerBlock+j,1) = set;
        numbs((i-1)*4*repsPerBlock+j,1) = nums(i);

        a = randperm(nums(i)); 
        if 5 <= nums(i) <= 8
            size = 2;
            jitArray = [1,-1];
            jitArray = Shuffle(jitArray);
        elseif 8 < nums(i) <= 13
            size = 4;
            jitArray = [1,1,-1,-1];
            jitArray = Shuffle(jitArray);
        else
            size = 6;
            jitArray = [1,1,1,-1,-1,-1];
            jitArray = Shuffle(jitArray);
        end;
        jitCount = 1; %counts the number of jitters already put
        
        %size = floor(nums(i)/4);
        indx = i;
        

        b = zeros(size,1);
        for k = 1:size
            b(k,1) = a(k);
        end;

        for z = 1:nums(i)
            if ~ismember(z,b) && z ~= nums(i)
                durations(z,(i-1)*4*repsPerBlock+j) = durs(set,indx);
                intervals(z,(i-1)*4*repsPerBlock+j) = ints(set,indx);
            elseif ~ismember(z,b) && z == nums(i)
                durations(z,(i-1)*4*repsPerBlock+j) = durs(set,indx);
            elseif ismember(z,b) && z ~= nums(i)
                durJit = durs(set,indx)-0.04;
                isiJit = ints(set,indx) -0.04;
                durations(z,(i-1)*4*repsPerBlock+j)= durs(set,indx)+jitArray(jitCount)*durJit;
                intervals(z,(i-1)*4*repsPerBlock+j) = ints(set,indx)-jitArray(jitCount)*isiJit;
                jitCount = jitCount + 1;
            else
                durJit = durs(set,indx)-0.04;
                isiJit = ints(set,indx) -0.04;
                durations(z,(i-1)*4*repsPerBlock+j) = durs(set,indx)-jitArray(jitCount)*durJit;
                intervals(z-1,(i-1)*4*repsPerBlock+j) = ints(set,indx)+jitArray(jitCount)*isiJit;
                jitCount = jitCount + 1;
            end;
        end;        

    end;
end;

