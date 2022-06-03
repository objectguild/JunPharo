Extension { #name : #JunGeometry }

{ #category : #'*Jun-Geometry-Curves' }
JunGeometry >> lineClass [
	self is3d ifTrue: [^Jun3dLine].
	self is2d ifTrue: [^Jun2dLine].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Curves' }
JunGeometry >> polylineClass [
	self is3d ifTrue: [^Jun3dPolyline].
	self is2d ifTrue: [^Jun2dPolyline].
	^self subclassResponsibility
]
