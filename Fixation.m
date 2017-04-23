function Fixation(w,rect,mon_width,v_dist,dur,color)
% Do initial flip...
fix_r       = 0.3; % radius of fixation point (deg)
[center(1), center(2)] = RectCenter(rect);
ppd = pi * (rect(3)-rect(1)) / atan(mon_width/v_dist/2) / 360;    % pixels per degree
fix_cord = [center-fix_r*ppd center+fix_r*ppd];
kc_esc = KbName('esc');

[X,Y] = RectCenter(rect);
FixCross = [X-2,Y-10,X+2,Y+10;X-10,Y-2,X+10,Y+2];

%xlswrite('fMRIlog',{int2str(cputime)},1,cellNo1);
t = timer('TimerFcn', 'stat=false','StartDelay',dur);
start(t);
while(strcmp(get(t,'Running'),'on'))
    Screen('FillRect', w, color, FixCross');
    % now define a string for each type of key press.
    [keyIsDown secs keycodes] = KbCheck();
    if ~isempty(keycodes)
        if keycodes(kc_esc)
            Priority(0);
            ShowCursor;
            Screen('CloseAll');
        end;
    end;
    Screen('Flip',w);
end;
