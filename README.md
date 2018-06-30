# PyDC #

Python wrapper package to interact with models you write int the probabilistic logic programming language [Distributional Clauses](https://bitbucket.org/problog/dc_problog/src/master/).

## Requirements ##

First make sure that you have installed Distributional Clauses (including YAP) following the instructions on the repo of Distributional Clauses.

## Installation ##

First clone the repo to your machine:
```
git clone https://github.com/ML-KULeuven/PyDC.git pydc
```
and execute the following steps:
```
cd pydc
python setup.py install --force
```
This should build and install the PyDC library on your machine.

## Test ##

To make sure that everything is in order try running one of the examples, e.g.:
```
python example/example_dc/example_dc.py
```
The examples are quiet self explanatory and should describe most of the API-options available in wrapper.
