Extension { #name : #String }

{ #category : #'*Jun-Pharo' }
String >> asFilename [ 

	"Compatibility method to prevent the need to refactor Jun code."

	^ self asFileReference 
]
