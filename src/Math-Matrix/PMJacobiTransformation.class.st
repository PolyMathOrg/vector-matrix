"
```
| m jacobi eigenvalues eigenvectors |
m := PMSymmetricMatrix rows: #((84 -79 58 55)
                                 (-79 84 -55 -58)
                                 (58 -55 84 79)
                                 (55 -58 79 84)).
jacobi := PMJacobiTransformation matrix: m.
eigenvalues := jacobi evaluate.
eigenvectors := jacobi transform columnsCollect: [ :each | each].
```
"
Class {
	#name : #PMJacobiTransformation,
	#superclass : #Object,
	#instVars : [
		'precision',
		'desiredPrecision',
		'maximumIterations',
		'result',
		'lowerRows',
		'transform'
	],
	#category : #'Math-Matrix'
}

{ #category : #creation }
PMJacobiTransformation class >> matrix: aSymmetricMatrix [
	^ super new initialize: aSymmetricMatrix
]

{ #category : #creation }
PMJacobiTransformation class >> new [
	"Prevent using this message to create instances."

	^ self error: 'Illegal creation message for this class'
]

{ #category : #accessing }
PMJacobiTransformation >> desiredPrecision: aNumber [
	"Defines the desired precision for the result."

	aNumber > 0 ifFalse: [ ^ self error: 'Illegal precision: ' , aNumber printString ].
	desiredPrecision := aNumber
]

{ #category : #operation }
PMJacobiTransformation >> evaluate [
	"Perform the iteration until either the desired precision is attained or the number of iterations exceeds the maximum."

	| iterations |
	iterations := 0.
	[
	iterations := iterations + 1.
	precision := self evaluateIteration.
	self hasConverged or: [ iterations >= maximumIterations ] ] whileFalse.
	self finalizeIterations.
	^ result
]

{ #category : #operation }
PMJacobiTransformation >> evaluateIteration [

	| indices |
	indices := self largestOffDiagonalIndices.
	self transformAt: (indices at: 1) and: (indices at: 2).
	^ precision
]

{ #category : #transformation }
PMJacobiTransformation >> exchangeAt: anInteger [
	"Private"

	| temp n |
	n := anInteger + 1.
	temp := result at: n.
	result at: n put: (result at: anInteger).
	result at: anInteger put: temp.
	transform do: [ :each |
		temp := each at: n.
		each at: n put: (each at: anInteger).
		each at: anInteger put: temp ]
]

{ #category : #operation }
PMJacobiTransformation >> finalizeIterations [
	"Transfer the eigenValues into a vector and set this as the result.
		 eigen values and transform matrix are sorted using a bubble sort."

	| n |
	n := 0.
	result := lowerRows collect: [ :each |
		          n := n + 1.
		          each at: n ].
	self sortEigenValues
]

{ #category : #testing }
PMJacobiTransformation >> hasConverged [

	^ precision <= desiredPrecision
]

{ #category : #initialization }
PMJacobiTransformation >> initialize [

	super initialize.
	desiredPrecision := Float machineEpsilon.
	maximumIterations := 50
]

{ #category : #initialization }
PMJacobiTransformation >> initialize: aSymmetricMatrix [
	"Private"

	| numberOfRows |
	numberOfRows := aSymmetricMatrix numberOfRows.
	lowerRows := Array new: numberOfRows.
	transform := Array new: numberOfRows.
	1 to: numberOfRows do: [ :k |
		lowerRows at: k put: ((aSymmetricMatrix rowAt: k) copyFrom: 1 to: k).
		transform at: k put: ((Array new: numberOfRows)
				 atAllPut: 0;
				 at: k put: 1;
				 yourself) ]
]

{ #category : #accessing }
PMJacobiTransformation >> largestOffDiagonalIndices [
	"Private"

	| n m abs |
	n := 2.
	m := 1.
	precision := ((lowerRows at: n) at: m) abs.
	1 to: lowerRows size do: [ :i |
		1 to: i - 1 do: [ :j |
			abs := ((lowerRows at: i) at: j) abs.
			abs > precision ifTrue: [
				n := i.
				m := j.
				precision := abs ] ] ].
	^ Array with: m with: n
]

{ #category : #accessing }
PMJacobiTransformation >> maximumIterations: anInteger [
	"Defines the maximum number of iterations."

	(anInteger isInteger and: [ anInteger > 1 ]) ifFalse: [ ^ self error: 'Invalid maximum number of iteration: ' , anInteger printString ].
	maximumIterations := anInteger
]

{ #category : #printing }
PMJacobiTransformation >> printOn: aStream [
	"Append to the argument aStream, a sequence of characters that describes the receiver."

	lowerRows do: [ :each | each printOn: aStream ] separatedBy: [ aStream cr ]
]

{ #category : #transformation }
PMJacobiTransformation >> sortEigenValues [
	"Private - Use a bubble sort."

	| numberOfRows bound |
	numberOfRows := lowerRows size.
	bound := numberOfRows.
	[ bound = 0 ] whileFalse: [
		| m |
		m := 0.
		1 to: bound - 1 do: [ :j |
			(result at: j) abs > (result at: j + 1) abs ifFalse: [
				self exchangeAt: j.
				m := j ] ].
		bound := m ]
]

{ #category : #transformation }
PMJacobiTransformation >> transform [

	^ PMMatrix rows: transform
]

{ #category : #transformation }
PMJacobiTransformation >> transformAt: anInteger1 and: anInteger2 [
	"Private"

	| d t s c tau apq app aqq arp arq |
	apq := (lowerRows at: anInteger2) at: anInteger1.
	apq = 0 ifTrue: [ ^ nil ].
	app := (lowerRows at: anInteger1) at: anInteger1.
	aqq := (lowerRows at: anInteger2) at: anInteger2.
	d := aqq - app.
	arp := d * 0.5 / apq.
	t := arp > 0
		     ifTrue: [ 1 / ((arp squared + 1) sqrt + arp) ]
		     ifFalse: [ 1 / (arp - (arp squared + 1) sqrt) ].
	c := 1 / (t squared + 1) sqrt.
	s := t * c.
	tau := s / (1 + c).
	1 to: anInteger1 - 1 do: [ :r |
		arp := (lowerRows at: anInteger1) at: r.
		arq := (lowerRows at: anInteger2) at: r.
		(lowerRows at: anInteger1) at: r put: arp - (s * (tau * arp + arq)).
		(lowerRows at: anInteger2) at: r put: arq + (s * (arp - (tau * arq))) ].
	anInteger1 + 1 to: anInteger2 - 1 do: [ :r |
		arp := (lowerRows at: r) at: anInteger1.
		arq := (lowerRows at: anInteger2) at: r.
		(lowerRows at: r) at: anInteger1 put: arp - (s * (tau * arp + arq)).
		(lowerRows at: anInteger2) at: r put: arq + (s * (arp - (tau * arq))) ].
	anInteger2 + 1 to: lowerRows size do: [ :r |
		arp := (lowerRows at: r) at: anInteger1.
		arq := (lowerRows at: r) at: anInteger2.
		(lowerRows at: r) at: anInteger1 put: arp - (s * (tau * arp + arq)).
		(lowerRows at: r) at: anInteger2 put: arq + (s * (arp - (tau * arq))) ].
	1 to: lowerRows size do: [ :r |
		arp := (transform at: r) at: anInteger1.
		arq := (transform at: r) at: anInteger2.
		(transform at: r) at: anInteger1 put: arp - (s * (tau * arp + arq)).
		(transform at: r) at: anInteger2 put: arq + (s * (arp - (tau * arq))) ].
	(lowerRows at: anInteger1) at: anInteger1 put: app - (t * apq).
	(lowerRows at: anInteger2) at: anInteger2 put: aqq + (t * apq).
	(lowerRows at: anInteger2) at: anInteger1 put: 0
]
