% Simple Heartrate Varibility Calculator
% Written by Zach Vesoulis for "Big Data and the Smallest People:
% Leveraging Informatics and Machine Learning to Improve Your Clinical and
% Research Practice" Workshop presented at the 2023 PAS Annual Meeting
% Published under GPL-3.0 license

%if running within Octave environment, load the statistics package before running this code
% pkg load statistics

%figure out the number of complete 10 min windows in recording
%in this case, data are sampled every 2 sec, that means 300 samples is 10 min
%floor is used to round down
num_windows=floor(length(vdata)/300);

%set the output matrix to blank, in case this isn't the first time running
%the code
hrv_sd=[];

%extract HR data from the imported file.  in this example HR data is in
%column 1 (can be verified by looking at vname).  other data sources will
%require different code
hr_data=(vdata(:,1));

%very simple error correction, set any HR <0 or >250 (clear errors) to NaN
hr_data(hr_data<0)=NaN;
hr_data(hr_data>250)=NaN;

%loop through all complete windows, calculate the standard deviation of the HR in the
%window and save to a new row in the output variable hrv_sd
for i=1:num_windows
    start=1+((i-1)*300);
    stop=300+((i-1)*300);
    selected_hr=hr_data(start:stop);
    hrv_sd(i)=std(selected_hr,"omitnan");
end

%plot
subplot(1,2,1)
plot(hr_data)
title('HR data')

subplot(1,2,2)
plot(hrv_sd)
title('HR SD in 10-min windows')
