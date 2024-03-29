Class {
	#name : #PMRestTest,
	#superclass : #TestCase,
	#category : #'Math-Matrix-Tests'
}

{ #category : #tests }
PMRestTest >> testEqualsTo [

	| a b |
	a := PMMatrix
		     rows: 5
		     columns: 7
		     random: 5.0
		     generator: (Random seed: 42).
	b := a deepCopy.
	self assert: (a closeTo: b).
	b rowAt: 4 columnAt: 6 put: 6.
	self deny: (a closeTo: b)
]

{ #category : #tests }
PMRestTest >> testNewRandom [

	| a |
	a := PMSymmetricMatrix new: 7 random: 5.0 generator: (Random seed: 42).
	self assert: a isSymmetric
]

{ #category : #tests }
PMRestTest >> testSwapColumnWithColumn [
	| a |
	a := PMMatrix new initializeRows: #(#(5 40 1) #(3 0 1) #(2 7 1)).
	a swapColumn: 2 withColumn: 1.
	self
		assert: a
		equals: (PMMatrix new initializeRows: #(#(40 5 1) #(0 3 1) #(7 2 1)))
]
