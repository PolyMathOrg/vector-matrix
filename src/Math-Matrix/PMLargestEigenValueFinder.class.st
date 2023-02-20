"
```
| m finder eigenvalue eigenvector nextFinder nextEigenvalue nextEigenVector |
m := PMMatrix rows: #( ( 84 -79  58 55)
						(-79  84 -55 -58)
						( 58 -55  84  79) 
						( 55 -58  79  84) ).
finder := PMLargestEigenValueFinder matrix: m.
eigenvalue := finder evaluate.
eigenvector := finder eigenvector.
nextFinder := finder nextLargestEigenValueFinder.
nextEigenvalue := nextFinder evaluate.
nextEigenvector := nextFinder eigenvector.
```
"
Class {
	#name : #PMLargestEigenValueFinder,
	#superclass : #Object,
	#instVars : [
		'precision',
		'desiredPrecision',
		'maximumIterations',
		'result',
		'matrix',
		'eigenvector',
		'transposeEigenvector'
	],
	#category : #'Math-Matrix'
}

{ #category : #information }
PMLargestEigenValueFinder class >> defaultPrecision [
	"Private - Answers the default precision for newly created instances."
	^PMFloatingPointMachine new defaultNumericalPrecision
]

{ #category : #creation }
PMLargestEigenValueFinder class >> matrix: aMatrix [
	"Create a new instance of the receiver for a given matrix and default precision."

	^ self new
		initialize: aMatrix;
		yourself
]

{ #category : #creation }
PMLargestEigenValueFinder class >> matrix: aMatrix precision: aNumber [
	"Create a new instance of the receiver for a given matrix and desired precision."

	^ self new
		initialize: aMatrix;
		desiredPrecision: aNumber;
		yourself
]

{ #category : #accessing }
PMLargestEigenValueFinder >> desiredPrecision: aNumber [
	"Defines the desired precision for the result."

	aNumber > 0 ifFalse: [ ^ self error: 'Illegal precision: ' , aNumber printString ].
	desiredPrecision := aNumber
]

{ #category : #information }
PMLargestEigenValueFinder >> eigenvalue [
	"Answer the eigen value found by the receiver."

	^ result
]

{ #category : #information }
PMLargestEigenValueFinder >> eigenvector [
	"Answer the normalized eigen vector found by the receiver."

	^ eigenvector * (1 / eigenvector norm)
]

{ #category : #operation }
PMLargestEigenValueFinder >> evaluate [
	"Perform the iteration until either the desired precision is attained or the number of iterations exceeds the maximum."

	| iterations |
	iterations := 0.
	self initializeIterations.

	[
	iterations := iterations + 1.
	precision := self evaluateIteration.
	self hasConverged or: [ iterations >= maximumIterations ] ] whileFalse: [  ].

	^ result
]

{ #category : #operation }
PMLargestEigenValueFinder >> evaluateIteration [
	"Iterate the product of the matrix of the eigen vector and the transpose."

	| oldEigenvalue |
	oldEigenvalue := result.
	transposeEigenvector := transposeEigenvector * matrix.
	transposeEigenvector := transposeEigenvector * (1 / (transposeEigenvector at: 1)).
	eigenvector := matrix * eigenvector.
	result := eigenvector at: 1.
	eigenvector := eigenvector * (1 / result).
	^ oldEigenvalue
		  ifNil: [ 2 * desiredPrecision ]
		  ifNotNil: [ (result - oldEigenvalue) abs ]
]

{ #category : #testing }
PMLargestEigenValueFinder >> hasConverged [

	^ precision <= desiredPrecision
]

{ #category : #initialization }
PMLargestEigenValueFinder >> initialize [

	super initialize.
	desiredPrecision := Float machineEpsilon.
	maximumIterations := 100
]

{ #category : #initialization }
PMLargestEigenValueFinder >> initialize: aMatrix [
	"Defines the matrix for the receiver."

	matrix := aMatrix
]

{ #category : #operation }
PMLargestEigenValueFinder >> initializeIterations [
	"Initialize the iterations (subclasses must write their own method and call this one last)."

	eigenvector := PMVector new: matrix numberOfRows.
	eigenvector atAllPut: 1.0.
	transposeEigenvector := PMVector new: eigenvector size.
	transposeEigenvector atAllPut: 1.0
]

{ #category : #accessing }
PMLargestEigenValueFinder >> maximumIterations: anInteger [
	"Defines the maximum number of iterations."

	(anInteger isInteger and: [ anInteger > 1 ]) ifFalse: [ ^ self error: 'Invalid maximum number of iteration: ' , anInteger printString ].
	maximumIterations := anInteger
]

{ #category : #creation }
PMLargestEigenValueFinder >> nextLargestEigenValueFinder [
	"Return an eigen value finder for the same eigen values of the receiver except the one found."

	| norm |
	norm := 1 / (eigenvector * transposeEigenvector).
	^ self class
		  matrix: matrix * ((PMSymmetricMatrix identity: eigenvector size) - (eigenvector * norm tensorProduct: transposeEigenvector))
		  precision: desiredPrecision
]
