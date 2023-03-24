% Data import and visualization demonstrattion
% Written by Zach Vesoulis for "Big Data and the Smallest People:
% Leveraging Informatics and Machine Learning to Improve Your Clinical and
% Research Practice" Workshop presented at the 2023 PAS Annual Meeting
% Published under GPL-3.0 license

% If running within Octave environment, load the statistics package before running this code
% pkg load statistics.

% This script assumes input data from the UVA dataverse library,
% specifically the one available from Niestroy et al. Replication Data for: Discovery of
% signatures of fatal neonatal illness in vital signs using highly comparative 
% time-series analysis available at https://doi.org/10.18130/V3/VJXODP

% There are three key variables in this data:
% vname: Names of vital signs contained in the file (HR, SPO2, ART-M, etc.)
%
% vdata: Raw data stored in columns match vname.  For example, if HR is the
% first element in vname, the first column of vdata is the HR.  If a sensor
% is not running, the column will be filled with NaN (not a number).
% 
% vt: Time vector, seconds since midnight on day of birth.  The values
% match rows in vdata; data in the same row were captured at the same
% second across all columns.

% First, lets open the dataset caled NICU_1007_vitals.mat.

% Now, let's use an example to illustrate how to use the data.  Lets say we want
% to isolate all of the Spo2 data into a new variable called
% "patient_spo2."  In the vname variable we can see two SpO2 variables, one
% called SPO2-% and one called SPO2-R.  The first is the variable we are
% looking for, the second is the pulse rate (HR measured by pulse
% oximeter).  Since SPO2-% is the 3rd variable, we know that column 3 in
% vdata is the corresponding column.

patient_spo2=vdata(:,3);

% Let's do the same thing with the HR and pull it into a variable called "patient_hr".  
% Going back to vname, we see that HR is the third variable, so we do the
% same command but substitute column 1.

patient_hr=vdata(:,1);

% If we want to calculate the mean SpO2 and HR of this patient over the entire
% recording, we run these commands:

mean_spo2=mean(patient_spo2)
mean_hr=mean(patient_hr)

% Both return NaN, why?  Recall that NaN stands for not a number.  When we
% are doing statistical calculations, this value cannot be interpreted.  We
% need to adjust our code to leave out the NaNs

mean_spo2=mean(patient_spo2, "omitnan")
mean_hr=mean(patient_hr, "omitnan")

% Now let's visualize our data by running the plot command.  Note that the
% plotter leaves out the NaN values automatically.

plot(patient_spo2)

% Wow, that is a lot of data (6.1 million points!) and too much to take in
% all at once.  Lets look at a 2-3 hour subsection of the data where some
% interesting things are going on.

plot(patient_spo2(560344:565323))

% There are a lot of desaturation events going on including a prolonged
% severe one near the end.  I wonder what is happening to the heart rate
% during these events, lets plot it for the same subsection.

plot(patient_hr(560344:565323))

% There are a lot of bradycardia events, but where did our SpO2 go?  You
% need to instruct the program to hold the previous plots.

plot(patient_spo2(560344:565323))
hold on
plot(patient_hr(560344:565323))
hold off

% Lets add a few more lines of code to make our figure more pretty
ylabel("Measurement")
xlabel("Timestamp")
title("HR and SpO2 over 2.75 hours")
grid on