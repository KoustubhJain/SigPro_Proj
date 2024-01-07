function audio_with_reverb = reverb(filename,delay)
    %Filename as a string, delay in seconds
    [og_sig,fs] = audioread(filename);
    [rows,cols] = size(og_sig);
    if rows<cols
        og_sig = transpose(og_sig);
    end

    %Impulse train
    delayed_sample = delay*fs;
    imp_train = zeros(2*delayed_sample,1);
    imp_train(1,1) = 1;
    imp_train(delayed_sample,1) = 0.5; %first echo with 50% attenuation
    imp_train(2*delayed_sample,1) = 0.25; %second echo with 50% attenuation

    %adding reverb via convolution
    left_reverb = conv(imp_train,og_sig(:,1));
    if cols == 2
        %In case of stereo audio
        right_reverb = conv(imp_train,og_sig(:,2));
        right_reverb = right_reverb*0.891/max(abs(right_reverb));
        left_reverb = left_reverb*0.891/max(abs(left_reverb));
        audio_with_reverb = [left_reverb,right_reverb];
    elseif cols == 1
        %In case of mono audio
        audio_with_reverb = left_reverb;
        audio_with_reverb = audio_with_reverb*0.891/max(abs(audio_with_reverb));
    end

    % Normalise audio to be between -1dB to 1dB --> all values must be
    % between -0.891 to 0.891
    audiowrite("echoed_audio.wav",audio_with_reverb,fs);
    
%end