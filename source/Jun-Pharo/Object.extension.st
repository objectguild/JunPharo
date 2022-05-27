Extension { #name : #Object }

{ #category : #'*Jun-Pharo' }
Object >> messageNotUnderstoodSignal [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ MessageNotUnderstood 
]

{ #category : #'*Jun-Pharo' }
Object >> respondsToArithmetic [

	"Compatibility method to prevent the need to refactor Jun code."

	^ false
]
