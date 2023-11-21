# About
This repo is to analyze a set of tissue data and return
curve fitted graphs of specified model.
## Instructions
The macro will automatically detect if input file is an existing 
table import or a brand new .txt file. ***Remember to clean up raw .txt 
file (experiment info left in is fine).***
If imported data is a matrix, assign your time, force and epsilon vectors 
to data.time, data.force and data.eps, respectively before proceeding.

***BEFORE RUNNING THE MACRO***
>Saving data<
To save data over multiple runs: set `savedata` to `'y'`
To run once: set `savedata` to `'n'`. This will clear all data before every 
new run.

> Importing rubber disc data
To import rubber disc experiments: set *importdata* to 'y'. The macro will 
import a set of cleaned-up data from two rubber disc experiments. Assign
the appropriate variable to *filename*.

> Setting initial guess
Initial guesses for models are set on line 10 and 11 for 
relaxation and ramp.

> Model selection
Basic 3ES and 2ES models are defined in *models.m*. Variable *modelLib* is 
the "library" of models that the user can later define different models.
  
Set *model_relax* and *model_ramp* to their respective fit models. 
Example: 3ES Relaxation 
>> model_relax=modelLib.relax_3es

### List of available models:
> Ramp
- Linear: 'poly1' ***(WITH THE SINGLE QUOTE)***
- 3-Element Solid: ramp_3es
> Relaxation
- 2-Element Solid: relax_2es
- 3-Element Solid: relax_3es

