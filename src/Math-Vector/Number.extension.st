Extension { #name : #Number }

{ #category : #'*Math-Vector' }
Number >> addWithVector: aVector [
	"Adds itself to each element of the vector"
	^ aVector collect: [ :each | each + self ]
]

{ #category : #'*Math-Vector' }
Number >> productWithVector: aVector [
		"Answers a new vector product of the receiver with aVector."
	^aVector collect: [ :each | each * self]
]
