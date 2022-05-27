Extension { #name : #Number }

{ #category : #'*Jun-Pharo' }
Number >> asDouble [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ self asFloat
]
