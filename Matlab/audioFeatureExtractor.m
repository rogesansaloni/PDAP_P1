function aFE = audioFeatureExtractor (path_senal)
    %Usada para definit los atributos que analizaremos de los audios de
    %entrada.
    [audioInput, fs] = audioread(path_senal);
    Ov = 0.9;
    %Se definen (inventan) los valores de longitud de la trama y numero de
    %muestras solapadas 
    aFE = audioFeatureExtractor( ...
    "SampleRate",fs, ...
    "Window",hamming(round(0.03*fs),"periodic"), ...
    "OverlapLength",round(0.02*fs), ...
    "mfcc",true, ...
    "mfccDelta",true, ...
    "mfccDeltaDelta",true, ...
    "pitch",true, ...
    "spectralCentroid",true);

    features = extract(aFE, audioInput);
    idx = info(aFE);
    
    t = linspace(0,size(audioInput,1)/fs,size(features,1));
    plot(t,features(:,idx.pitch))
    title('Pitch')
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    
    
end