# Workshop software installation guide
## _Hopefully this is painless_

We are very excited for you to join our workshop!  Although part of the workshop will be didactic with brief lectures from the presenters, most of the workshop will be live demonstration of data analysis techniques.  In order for things to run smoothly, all attendees should bring a fully charged laptop computer with the software described in this guide already installed and tested.  If you have any questions, please reach out via email.

**There will not be sufficient time for attendees to install new software during the session itself.  Please prepare in advance!!**

## Introduction
In the interactive part of the workshop, we will utilize anonymized real patient data to go through a number of important processes including: importing data, understanding variables, producing visualizations, and an introduction to analysis.  We will utilize two software packages, R and GNU Octave.  Both packages are available for Microsoft Window and Apple OS platforms, are open source, and are free of charge.

## GNU Octave installation
GNU Octave is a scientific programming lanaguage that is largely compatible with the commerical MATLAB platform, yet is available for free.  It is capable of loading large datasets, generating visualizations, and running analytic code.  The GNU Octave download page can be accessed [here](https://octave.org/download).  

### Windows installation
Scroll to the bottom of the page and download the Windows 64-bit installer labelled [octave-8.1.0-w64-installer.exe](https://ftpmirror.gnu.org/octave/windows/octave-8.1.0-w64-installer.exe).

Depending on the version of Windows you are using and your security settings, you may get a warning from Windows Defender.  Press "More Info" and "Run anwyway" to proceed with installation.  Additional security dialogs may appear, please select the option which allows you to proceed.  We recommend you select the default installation options

### Apple OSX installation
GNU Octave does not have a pre-built binary available for download from the main webpage, however there are two alternative methods for obtaining the software
- A pre-built binary can be downloaded from the [Octave App Project](https://octave-app.org/Download.html).
- An alternative strategy for Apple users is to install using Homebrew, which requires two commands in Terminal
  - ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)```
  - ```brew install octave```

## R and R studio installation
R is a statistical software package with extensive data analysis
