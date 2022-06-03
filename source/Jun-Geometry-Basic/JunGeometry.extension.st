Extension { #name : #JunGeometry }

{ #category : #'*Jun-Geometry-Basic' }
JunGeometry >> angleClass [
	^JunAngle
]

{ #category : #'*Jun-Geometry-Basic' }
JunGeometry class >> mobiusRadius: mobiusRadius normalizedTheta: normalizedTheta stripRadius: stripRadius normalizedRadius: normalizedRadius [ 
	"JunGeometry mobiusRadius: (2/3) normalizedTheta: 0 stripRadius: (1/3) normalizedRadius: 1."

	"
	x = (R + (r * cos(theta / 2))) * cos(theta) 
	y = (R + (r * cos(theta / 2))) * sin(theta) 
	z = r * sin(theta / 2)
	"

	| theta phi point center x y z |
	theta := JunAngle fromRad: self doublePi * normalizedTheta.
	phi := theta * 2.0d reciprocal.
	x := (mobiusRadius + (stripRadius * phi cos)) * theta cos.
	y := (mobiusRadius + (stripRadius * phi cos)) * theta sin.
	z := stripRadius * phi sin.
	x abs < self accuracy ifTrue: [x := 0.0d].
	y abs < self accuracy ifTrue: [y := 0.0d].
	z abs < self accuracy ifTrue: [z := 0.0d].
	point := x , y , z.
	x := mobiusRadius * theta cos.
	y := mobiusRadius * theta sin.
	x abs < self accuracy ifTrue: [x := 0.0d].
	y abs < self accuracy ifTrue: [y := 0.0d].
	center := x , y , 0.0d.
	^(center to: point) atT: normalizedRadius
]

{ #category : #'*Jun-Geometry-Basic' }
JunGeometry >> pointClass [
	self is3d ifTrue: [^Jun3dPoint].
	self is2d ifTrue: [^Jun2dPoint].
	^self subclassResponsibility
]

{ #category : #'*Jun-Geometry-Basic' }
JunGeometry >> rotatedByDegrees: degrees [ 
	^self 
		transform: (self transformationClass rotate: (JunAngle fromDeg: degrees))
]

{ #category : #'*Jun-Geometry-Basic' }
JunGeometry class >> torusRadius: torusRadius normalizedTheta: normalizedTheta tubeRadius: tubeRadius normalizedPhi: normalizedPhi [ 
	"JunGeometry torusRadius: (2/3) normalizedTheta: 0 tubeRadius: (1/3) normalizedPhi: 0."

	"
	x = (R + (r * cos(phi))) * cos(theta) 
	y = (R + (r * cos(phi))) * sin(theta) 
	z = r * sin(phi)
	"

	| theta phi x y z point |
	theta := JunAngle fromRad: self doublePi * normalizedTheta.
	phi := JunAngle fromRad: self doublePi * normalizedPhi.
	x := (torusRadius + (tubeRadius * phi cos)) * theta cos.
	y := (torusRadius + (tubeRadius * phi cos)) * theta sin.
	z := tubeRadius * phi sin.
	x abs < self accuracy ifTrue: [x := 0.0d].
	y abs < self accuracy ifTrue: [y := 0.0d].
	z abs < self accuracy ifTrue: [z := 0.0d].
	point := x , y , z.
	^point
]
