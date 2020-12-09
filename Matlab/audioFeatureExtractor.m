function aFE = audioFeatureExtractor (senal)
    %Usada para definit los atributos que analizaremos de los audios de
    %entrada.

    %Se definen (inventan) los valores de longitud de la trama y numero de
    %muestras solapadas 
    fs = 8000;
    Ov = 0.9;

    y = fft(senal);
    
    
end

function calculatespectogram(Tw, Ov, fs, senal)
i = Tw * senal.fs;
j = i*Ov;
nfft = round(i);
noverlap = round(j);
ventana = rectwin(nfft);
[S, F, T] = spectrogram (senal.x, ventana, noverlap, nfft, fs);
imagesc(T,F,20*log(abs(S)));
xlabel('Tiempo (seg)');
ylabel('Frecuencia (Hz)');
set(gca,'ydir','normal');
end

function [S] = calculateMelSpectogram (fs, senal)

    [S] = melSpectogram(senal, fs);
end