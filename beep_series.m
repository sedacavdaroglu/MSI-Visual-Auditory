function [dur_num] = beep_series(a)

SAMPLE_FREQ = 8000;%8192;


start_beep = tic();


wavplay(a,SAMPLE_FREQ);
%sound(x, SAMPLE_FREQ);
dur_num = toc(start_beep);  