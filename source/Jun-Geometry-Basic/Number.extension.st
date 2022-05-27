Extension { #name : #Number }

{ #category : #'*Jun-Geometry-Basic' }
Number >> , aNumber [ 
	^Jun2dPoint
		x: self
		y: aNumber
]

{ #category : #'*Jun-Geometry-Basic' }
Number >> asDegrees [ 
	^JunAngle degrees: self
]

{ #category : #'*Jun-Geometry-Basic' }
Number >> asRadians [ 
	^JunAngle radians: self
]
