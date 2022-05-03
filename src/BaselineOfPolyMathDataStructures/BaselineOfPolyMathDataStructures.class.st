Class {
	#name : #BaselineOfPolyMathDataStructures,
	#superclass : #BaselineOf,
	#category : #BaselineOfPolyMathDataStructures
}

{ #category : #baselines }
BaselineOfPolyMathDataStructures >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		
		"Packages"
		spec 
			package: 'Math-Core';
			package: 'Math-Matrix' with: [ spec requires: #('Math-Core') ];
			package: 'Math-Tests-Core' with: [ spec requires: #('Math-Core') ];
			package: 'Math-Tests-Matrix' with: [ spec requires: #('Math-Matrix') ] ].
]
