Extension { #name : #AbstractFileReference }

{ #category : #'*Jun-Pharo' }
AbstractFileReference >> asFilename [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ self asFileReference 
]
