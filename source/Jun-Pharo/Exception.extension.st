Extension { #name : #Exception }

{ #category : #'*Jun-Pharo' }
Exception class >> handle: handlerAction do: blockClosure [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ blockClosure on: self do: handlerAction
]
