function drawAllStim ()
%Author: Seda Cavdaroglu
%Date: 10.10.2013

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



nums = [5 6 7 8 9 10 11 13 15 17 20];
%nums = [5 7 11 16];
sets = [1 2 3 4];

[width, height]=Screen('WindowSize', w);


for i = 1:length(sets)
    for j = 1:length(nums)
        [dur,inter] = Vis_GetDursInt(nums(j),sets(i));
        dur = dur * 65;
        inter = inter * 65;
        
        y_inter = center(2)-height/2+height/(length(nums))*j-15;
        y_dur = y_inter-50;
        x_start = -width/2+550+(width/4)*i;
        
        
        for z = 1:length(dur)
            if z ~= 1
                x_start = x_start+dur(z-1)+inter(z-1);
                %Screen('DrawLine', w,green, x_start-inter(i-1)*1000, y_inter, x_start, y_inter);
            end;
            Screen('DrawLine', w,black, x_start, y_dur, x_start+dur(z), y_dur);
            Screen('DrawLine', w,black, x_start, y_dur, x_start, y_inter);
            Screen('DrawLine', w,black, x_start+dur(z), y_dur, x_start+dur(z), y_inter);
            if z ~= length(dur)
                Screen('DrawLine', w,black, x_start+dur(z), y_inter, x_start+dur(z)+inter(z), y_inter);
            end;            
        end;
    end
end
   
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