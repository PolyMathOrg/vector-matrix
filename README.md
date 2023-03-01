<p align="center"><img alt="PolyMath" src="https://raw.githubusercontent.com/PolyMathOrg/PolyMath/master/assets/logos/logo.png" style="width: 25%; height: 25%">
<h1 align="center">[Vector Matrix]</h1>
  <p align="center">
    Scientific Computing with Pharo
    <br>
    <a href="https://github.com/PolyMathOrg/PolyMath/wiki"><strong>Explore the docs »</strong></a>
    <br>
    <br>
    <a href="https://github.com/PolyMathOrg/PolyMath/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/PolyMathOrg/PolyMath/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

[![CI](https://github.com/PolyMathOrg/vector-matrix/actions/workflows/test.yml/badge.svg)](https://github.com/PolyMathOrg/vector-matrix/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/vector-matrix/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/vector-matrix?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/vector-matrix/master/LICENSE)

## Description

A project to manage the data structures of PolyMaths. It currently includes the Vector and Matrix Pharo implementation.

## Installation

You can load all the packages into a fresh Pharo image by going to the Playground (Ctrl + OW/Cmd + OW) and executing the following expression (select it and press Do-it button or Ctrl+D/Cmd+D):

```smalltalk
    Metacello new
        baseline: 'MathVectorMatrix';
        repository: 'github://PolyMathOrg/vector-matrix/src';
	onWarningLog;
	onConflictUseIncoming;
        load ]
```

This should load the default version of the project (you can also specify another version or branch).

To add it to your Baseline:

```smalltalk
    spec
	    baseline: 'MathVectorMatrix'
	    with: [ spec repository: 'github://PolyMathOrg/vector-matrix/src' ]
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.
