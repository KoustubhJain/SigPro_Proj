function clean_audio = echo_cancellation(echoed_sig,desired_sig)
    %Echoed Audio,Clean Audio. Please note output is a sequence.
    [~,cols] = size(desired_sig);
    if cols == 1
        window_size = 32;
        loops = size(desired_sig);
    
        filt_in = zeros(window_size,1);
        filt_coeff = zeros(window_size,1);
    
        step_size = 0.014;
    
        for k=1:loops
            for m=window_size:-1:2
             filt_in(m)=filt_in(m-1);
            end
            filt_in(1)=echoed_sig(k); %Insert new sample at beginning of input
            
            clean_audio(k)=filt_coeff'*filt_in; %Output signal after adaptive filter
            error=desired_sig(k)-clean_audio(k); %ERROR
            temp_filt_coeff = filt_coeff + 2*step_size*error*filt_in;%Update filter 
            filt_coeff = temp_filt_coeff;
        end
    elseif cols == 2
        in_left = echoed_sig(:,1);
        in_right = echoed_sig(:,2);
        desired_left = desired_sig(:,1);
        desired_right = desired_sig(:,2);
        out_left = echo_cancellation(in_left,desired_left);
        out_right = echo_cancellation(in_right,desired_right);
        clean_audio = [out_left;out_right];
    end
end