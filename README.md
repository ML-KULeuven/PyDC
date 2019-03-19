# PyDC #

Python wrapper package to interact with models you write int the probabilistic logic programming language [Distributional Clauses](https://bitbucket.org/problog/dc_problog/src/master/).

## Requirements ##

First make sure that you have installed Distributional Clauses (including YAP) following the instructions on the repo of Distributional Clauses.

If you want to have access to the function `str2term`, which parses a string into a python object that emulates the semantics of Prolog terms, you need to additionally install the [ProbLog](https://bitbucket.org/problog/problog/src/master/) library.

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
python examples/example_dc/example_dc.py
```
The examples are quiet self explanatory and should describe most of the API-options available in wrapper.


## Cite ##

If you use the PyDC wrapper in your research please cite as:
```
@inproceedings{zuidberg2018reactive,
  title={Reactive Probabilistic Programming},
  author={Zuidberg Dos Martires, Pedro and Dumancic, Sebastijan},
  booktitle={The International Conference on Probabilistic Programming, Location: Boston, United States of America},
  year={2018}
}
```

or put the link to this repo in a footnote. Thanks!
