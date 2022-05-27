Extension { #name : #Point }

{ #category : #'*Jun-Geometry-Basic' }
Point >> , aNumber [ 
	^Jun3dPoint
		x: self x
		y: self y
		z: aNumber
]
