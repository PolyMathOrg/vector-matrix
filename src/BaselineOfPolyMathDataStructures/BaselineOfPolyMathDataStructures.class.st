Class {
	#name : #BaselineOfPolyMathDataStructures,
	#superclass : #BaselineOf,
	#category : #BaselineOfPolyMathDataStructures
}

{ #category : #baselines }
BaselineOfPolyMathDataStructures >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'Math-Vector';
			package: 'Math-Matrix' with: [ spec requires: #( 'Math-Vector' ) ];
			package: 'Math-Tests-Vector' with: [ spec requires: #( 'Math-Vector' ) ];
			package: 'Math-Tests-Matrix' with: [ spec requires: #( 'Math-Matrix' ) ].

		spec
			group: 'Core' with: #( 'Math-Vector' 'Math-Matrix' );
			group: 'Tests' with: #( 'Math-Tests-Vector' 'Math-Tests-Matrix' ) ].

	spec for: #( #'pharo9.x' #'pharo10.x' ) do: [ 
		spec
			package: 'Math-Matrix' with: [ spec requires: #( 'Math-DataStructures-Pharo11' ) ];
			package: 'Math-DataStructures-Pharo11' ]
]
