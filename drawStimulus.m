function drawStimulus(dur,inter)
%Author: Seda Cavdaroglu
%Date: 09.10.2013

%for visualization
AssertOpenGL;

%define colors
black = [0 0 0];
red = [255 0 0];
blue = [0 0 255];
white = [255 255 255];
green = [0 255 0];


%create the screen
screens=Screen('Screens');
screenNumber=max(screens);
[w, rect] = Screen('OpenWindow', screenNumber, white);
[center(1), center(2)] = RectCenter(rect);

HideCursor;	% Hide the mouse cursor
Priority(MaxPriority(w));

%use the s char to start the task
kc_esc = KbName('esc');

y_dur = center(2)-50;
y_inter = center(2);
x_start = center(1)-200;

for i = 1:length(dur)
    if i ~= 1
        x_start = x_start+dur(i-1)+inter(i-1);        
        %Screen('DrawLine', w,green, x_start-inter(i-1)*1000, y_inter, x_start, y_inter); 
    end;
    Screen('DrawLine', w,black, x_start, y_dur, x_start+dur(i), y_dur);    
    Screen('DrawLine', w,blue, x_start, y_dur, x_start, y_inter);
    Screen('DrawLine', w,red, x_start+dur(i), y_dur, x_start+dur(i), y_inter);
    if i ~= length(dur)
        Screen('DrawLine', w,green, x_start+dur(i), y_inter, x_start+dur(i)+inter(i), y_inter);
    end;
    
end;

Screen('Flip',w);
pressed = 0;
while(~pressed)
    % now define a string for each type of key press.
    [keyIsDown secs keycodes] = KbCheck();
    if ~isempty(keycodes)
        if keycodes(kc_esc)
            %fclose(fid);
            Priority(0);
            ShowCursor;
            Screen('CloseAll');
            pressed = 1;
        end;
    end;
end;