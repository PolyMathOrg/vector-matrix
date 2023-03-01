Class {
	#name : #BaselineOfMathVectorMatrix,
	#superclass : #BaselineOf,
	#category : #BaselineOfMathVectorMatrix
}

{ #category : #baselines }
BaselineOfMathVectorMatrix >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'Math-Vector';
			package: 'Math-Matrix' with: [ spec requires: #( 'Math-Vector' ) ];
			package: 'Math-Vector-Tests' with: [ spec requires: #( 'Math-Vector' ) ];
			package: 'Math-Matrix-Tests' with: [ spec requires: #( 'Math-Matrix' ) ].

		spec
			group: 'Core' with: #( 'Math-Vector' 'Math-Matrix' );
			group: 'Tests' with: #( 'Math-Vector-Tests' 'Math-Matrix-Tests' ) ].

	spec for: #( #'pharo9.x' #'pharo10.x' ) do: [
		spec
			package: 'Math-Matrix' with: [ spec requires: #( 'Math-DataStructures-Pharo11' ) ];
			package: 'Math-DataStructures-Pharo11' ]
]
