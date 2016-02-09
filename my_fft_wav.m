% Audio Compression Example in MatLab
% You will need an audio file named holamundo.wav
% Using DFFT (Discrete Fast Fourier Transform), it compress an audio file 
% using a low pass filter.


clc
clear all


% --- Wav original --------------------------------------------------------
[y, Fs] = wavread('holamundo.wav');
q = y(1000:30000); % Duracion


% --- FFT y compresion de la señal ----------------------------------------
m = size(q,1);
TF = fft(q,m);
AA = abs(TF);
sz = size(TF, 1);

porcentaje = 0.91; % porcentaje de reduccion
% Filtro pasabajas
corte = floor(sz*porcentaje/2);
mitad = floor(sz/2);
TFc = TF;
TFc(mitad-corte:mitad+corte,1) = 0;
AAc = abs(TFc);
sz = size(TFc,1);


% --- Transformada inversa ------------------------------------------------
iTF = ifft(TFc);     % Inversa de Fourier
TF2 = fft(iTF, m);   % FFT de la señal comprimida (para graficar)
% Reproducir archivo comprimido
sound(real(iTF), Fs);


% --- Graficas ------------------------------------------------------------
subplot(2,1,1)
plot(q, 'k')
hold on
plot(real(iTF), 'r')
grid on
title('Tiempo')

subplot(2,1,2)
plot(real(TF), 'k')
hold on
plot(real(TF2), 'r')
grid on
title('Frecuencia')






