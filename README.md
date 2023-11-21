# About
This repo is to analyze a set of tissue data and return
curve fitted graphs of specified model.
## Instructions
The macro will automatically detect if input file is an existing 
table import or a brand new .txt file. ***Remember to clean up raw .txt 
file (experiment info left in is fine).***
If imported data is a matrix, assign your time, force and epsilon vectors 
to data.time, data.force and data.eps, respectively before proceeding..

***BEFORE RUNNING THE MACRO***
**MAKE SURE .TXT FILES GOES INTO `dataset`**
### Saving data

To save data over multiple runs: set `savedata` to `'y'`
To run once: set `savedata` to `'n'`. This will clear all data before every 
new run.

### Importing rubber disc data

To import rubber disc experiments: set `importdata` to `'y'`. The macro will 
import a set of cleaned-up data from two rubber disc experiments. Assign
the appropriate variable to `filename`.

### Setting initial guess (line 18-19)

Initial guesses for models are set on `line 18` for relaxation and 
`line 19` for ramp.

### Ranp Time range (line 24-25)

Edit time range for the ramp section.

### Model selection

Basic 3ES and 2ES models are defined in `models.m`. Variable `modelLib` is 
the "library" of models that the user can later define and add different models.
  
Set `model_relax`(line26) and `model_ramp`(line27) to their respective fit models.
Currently the macro fits both linear and 3ES for ramp. User can manually change `model` input on line 
57 and 64, respectively.
Example: 3ES Relaxation 
>`model_relax=modelLib.relax_3es`

### List of available models:
#### Ramp
- Linear: 'poly1' ***(WITH THE SINGLE QUOTE)***
- 3-Element Solid: ramp_3es
#### Relaxation
- 2-Element Solid: relax_2es
- 3-Element Solid: relax_3es


### Importing new models
User can also import new models by using the MATLAB built-in function `fit`.
to define a model per the documentation. Curve-fitting toolbox required.

## After hitting run
The macro will first ask for ramp time range input confirmation and plot the ramp data. 
If time input is correct, enter 'y'/'yes'/1 and follow instructions.
If not, enter anything else to stop the script.