Extension { #name : #JunGeometry }

{ #category : #'*Jun-Geometry-Pluralities' }
JunGeometry >> boundingBallsClass [
	self is3d ifTrue: [^Jun3dBoundingBalls].
	self is2d ifTrue: [^Jun2dBoundingBalls].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Pluralities' }
JunGeometry >> boundingBoxesClass [
	self is3d ifTrue: [^Jun3dBoundingBoxes].
	self is2d ifTrue: [^Jun2dBoundingBoxes].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Pluralities' }
JunGeometry >> trianglesClass [
	self is3d ifTrue: [^Jun3dTriangles].
	self is2d ifTrue: [^Jun2dTriangles].
	^self subclassResponsibility
]
