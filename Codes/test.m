%File for testing both functions: Echo creation and Echo Cancellation
file = "hindi_2s.wav";
delay = 3;
echoed_sig = reverb(file,delay);

[desired_sig,fs] = audioread(file);

clean = echo_cancellation(echoed_sig,desired_sig);

%plotting
t = (0:length(desired_sig)-1)/fs;
t_2 = (0:length(echoed_sig)-1)/fs;

figure
subplot(3,1,1)
plot(t,desired_sig)
grid on
title('Desired Signal')
xlabel('Time(s)')
ylabel('Amplitude')
subplot(3,1,2)
plot(t_2,echoed_sig)
grid on
title('Echoed Signal')
xlabel('Time(s)')
ylabel('Amplitude')
subplot(3,1,3)
plot(t,clean)
grid on
xlabel('Time(s)')
ylabel('Amplitude')
title('Filtered Signal')

saveas(gcf,'Echo_Cancellation.png')