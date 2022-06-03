Extension { #name : #JunGeometry }

{ #category : #'*Jun-Geometry-Boundaries' }
JunGeometry >> boundingBallClass [
	self is3d ifTrue: [^Jun3dBoundingBall].
	self is2d ifTrue: [^Jun2dBoundingBall].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Boundaries' }
JunGeometry >> boundingBoxClass [
	self is3d ifTrue: [^Jun3dBoundingBox].
	self is2d ifTrue: [^Jun2dBoundingBox].
	^self subclassResponsibility
]
