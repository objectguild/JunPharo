Extension { #name : #JunGeometry }

{ #category : #'*Jun-Geometry-Surfaces' }
JunGeometry >> circleClass [
	self is3d ifTrue: [^Jun3dCircle].
	self is2d ifTrue: [^Jun2dCircle].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Surfaces' }
JunGeometry >> planeClass [
	^JunPlane
]

{ #category : #'*Jun-Geometry-Surfaces' }
JunGeometry >> polygonClass [
	self is3d ifTrue: [^Jun3dPolygon].
	self is2d ifTrue: [^Jun2dPolygon].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Surfaces' }
JunGeometry >> triangleClass [
	self is3d ifTrue: [^Jun3dTriangle].
	self is2d ifTrue: [^Jun2dTriangle].
	^self subclassResponsibility
]
