"
Description
--------------------

One line summary. For example, ""I represent a paragraph of text"".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them.

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------



Internal Representation and Key Implementation Points.
--------------------

"
Class {
	#name : #BaselineOfPolyMathDataStructures,
	#superclass : #BaselineOf,
	#category : #BaselineOfPolyMathDataStructures
}

{ #category : #testing }
BaselineOfPolyMathDataStructures class >> isDeprecated [
	^ true
]

{ #category : #baselines }
BaselineOfPolyMathDataStructures >> baseline: spec [

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
