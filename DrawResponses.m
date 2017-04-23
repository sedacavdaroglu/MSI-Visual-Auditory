function DrawResponses(subNo,modality)
%Draws the stimuli-response curve for given subject

%Author: Seda Cavdaroglu
%Date: 09.09.2013

%open the text file to read the output
if modality == 1 %open the visual file
    subj_file = strcat('log_files\vis_subject_',num2str(subNo),'.txt');
elseif modality == 2 %open the auditory file
    subj_file = strcat('log_files\aud_subject_',num2str(subNo),'.txt');
elseif modality == 3 %open both files and draw on the same graph
    subj_file_vis = strcat('log_files\vis_subject_',num2str(subNo),'.txt');
    subj_file_aud = strcat('log_files\aud_subject_',num2str(subNo),'.txt');
end;

% Read the data, filling A in column order
% First line of the file:
%    0.00    1.00000000
if modality ~= 3
    fid = fopen(subj_file);
    A = fscanf(fid, '%g %g', [2 inf]);
    fclose(fid);

    % Transpose so that A matches
    % the orientation of the file
    A = A';
    A1 = A(:,1); %first row of A = numbers used
    A2 = A(:,2); %second row of A = responses
    B = [5,6,7,8,9,11,12,14,16,20];


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


    %fit cumulative gaussian function to the data
    figure;

    %tmp = 100 .* prop_greater_resp;
    %y = cdf('normal',prop_greater_resp,B');
    mu = std(prop_greater_resp);
    m = mean(prop_greater_resp);
    y = normcdf(prop_greater_resp,mu,m);

    y = smooth(y);
    [XI,IDEXACT] = findX(B,y',0.75);

    disp(XI); %display weber fraction

    %Display the WEBER FRACTION-75% percentile
    y2 = y';
    y2 = 100.*y2;

    axis([0.5 1 0 100]);
    plot(B',y2,'b');
    xlabel('Numbers');
    ylabel('Percentage of Correct Responses');
else %draw the psychophysics curves of both modalities in one graph
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
    B = [5,6,7,8,9,11,12,14,16,20];


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


    %fit cumulative gaussian function to the data
    figure;
    %hold on;

    %tmp = 100 .* prop_greater_resp;
    %y = cdf('normal',prop_greater_resp,B');
    mu = std(prop_greater_resp_aud);
    m = mean(prop_greater_resp_aud);
    y_aud = normcdf(prop_greater_resp_aud,mu,m);

    %y_aud = smooth(y_aud);
    [XI,IDEXACT] = findX(B,y_aud',0.75);

    disp(XI); %display weber fraction

    %Display the WEBER FRACTION-75% percentile
    y2_aud = y_aud';
    y2_aud = 100.*y2_aud;

    axis([0.5 1 0 100]);
    plot(B',y2_aud,'r');
    
    
    
    mu2 = std(prop_greater_resp_vis);
    m2 = mean(prop_greater_resp_vis);
    y_vis = normcdf(prop_greater_resp_vis,mu2,m2);

    %y_vis = smooth(y_vis);
    [XI2,IDEXACT2] = findX(B,y_vis',0.75);

    disp(XI2); %display weber fraction

    %Display the WEBER FRACTION-75% percentile
    y2_vis = y_vis';
    y2_vis = 100.*y2_vis;

    hold on;
    plot(B',y2_vis,'b');
    
    
    xlabel('Numbers');
    ylabel('Percentage of Correct Responses');
    
end;
