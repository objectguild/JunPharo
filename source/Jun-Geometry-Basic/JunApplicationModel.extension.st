Extension { #name : #JunApplicationModel }

{ #category : #'*Jun-Geometry-Basic' }
JunApplicationModel class >> alignedRectangleWithScreenCenter: extentPoint [ 
	"JunApplicationModel alignedRectangleWithScreenCenter: 400 @ 300."

	^(Jun2dPoint coerce: extentPoint) alignedRectangleWithScreenCenter
]

{ #category : #'*Jun-Geometry-Basic' }
JunApplicationModel >> neighborhoodPoints: displayPoint [ 
	^JunPoint neighborhoodPoints: displayPoint
]
