Extension { #name : #Float }

{ #category : #'*Jun-Pharo' }
Float >> coerce: aNumber [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ aNumber asFloat
]

{ #category : #'*Jun-Pharo' }
Float >> d [
	"Compatibility method to prevent the need to refactor Jun code."

	^ self
]

{ #category : #'*Jun-Pharo' }
Float >> generality [ 

	"Compatibility method to prevent the need to refactor Jun code.

	VisualWorks uses Float generality value 80. Since Pharo floats are double precision, we use 
	generality value 90 here (equal to Double in VisualWorks)."

	^ 90
]
