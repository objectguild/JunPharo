Class {
	#name : #JunOpenGL3dReference,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'object',
		'scale',
		'rotation',
		'translation',
		'extrusion',
		'transformedObject'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #accessing }
JunOpenGL3dReference class >> object: aJun3dObject [ 

	^ self new 
		object: aJun3dObject ;
		yourself
]

{ #category : #transforming }
JunOpenGL3dReference >> applyExtrusionTo: aJun3dObject [ 

	"Apply extrusion to aJun3dObject.

	Adapted from JunDXFParser>>#applyExtrusion:to:" 

	| v1 ev th av rl tf |

	v1 := 0 , 0 , 1.
	ev := extrusion unitVector.
	av := v1 product: ev.
	rl := Jun3dLine from: Jun3dPoint zero to: av.
	th := (v1 dotProduct: ev) arcCos.
	tf := Jun3dTransformation rotate: th around: rl.

	^ aJun3dObject transform: tf
]

{ #category : #transforming }
JunOpenGL3dReference >> applyTransformationTo: aJun3dObject [ 

	| newObject |

	newObject := aJun3dObject scaledBy: scale.
	(rotation isNil or: [ rotation = 0 ]) ifFalse: [ 
		newObject := newObject rotatedBy: (JunAngle fromDeg: rotation) ].
	newObject := newObject translatedBy: translation.
	extrusion isZero ifFalse: [ 
		newObject := self applyExtrusionTo: newObject ].

	newObject 
		name: object name asString , ' (Reference)' ;
		reference: object name.
	^ newObject
]

{ #category : #accessing }
JunOpenGL3dReference >> extrusion: aJun3dPoint [

	extrusion := aJun3dPoint.
	self 
		flushBounds ; 
		flushTransformedObject
]

{ #category : #flushing }
JunOpenGL3dReference >> flushTransformedObject [

	transformedObject := nil
]

{ #category : #enumerating }
JunOpenGL3dReference >> geometriesDo: aBlock [

	self transformedObject geometriesDo: aBlock
]

{ #category : #'lisp support' }
JunOpenGL3dReference >> kindName [

	^ #Reference
]

{ #category : #utilities }
JunOpenGL3dReference >> numberOfPolygons [

	^ object numberOfPolygons 
]

{ #category : #utilities }
JunOpenGL3dReference >> numberOfPolylines [

	^ object numberOfPolylines
]

{ #category : #accessing }
JunOpenGL3dReference >> object: aJun3dObject [ 

	object := aJun3dObject.
	self 
		flushBounds ; 
		flushTransformedObject.

	self reference: aJun3dObject name
]

{ #category : #utilities }
JunOpenGL3dReference >> objectsDo: aBlock [ 

	self transformedObject objectsDo: aBlock
]

{ #category : #accessing }
JunOpenGL3dReference >> printOn: aStream [ 

	aStream nextPutAll: self kindName printString.
	self reference ifNotNil: [ :reference | 
		aStream 
			nextPutAll: ': ' ; 
			nextPutAll: reference ]
]

{ #category : #rendering }
JunOpenGL3dReference >> renderOn: aRenderingContext [ 

	self error: 'Currently not supported: ' , thisContext methodSelector printString
]

{ #category : #converting }
JunOpenGL3dReference >> reversed [

	^ self copy
]

{ #category : #accessing }
JunOpenGL3dReference >> rotation: aNumber [ 

	rotation := aNumber.
	self 
		flushBounds ; 
		flushTransformedObject
]

{ #category : #accessing }
JunOpenGL3dReference >> scale: aJun3dPoint [

	scale := aJun3dPoint.
	self 
		flushBounds ; 
		flushTransformedObject
]

{ #category : #'lisp support' }
JunOpenGL3dReference >> toLispList [

	^ self transformedObject toLispList
]

{ #category : #transforming }
JunOpenGL3dReference >> transform: aTransformation [ 

	"Currently not supported"

	^ self copy
]

{ #category : #accessing }
JunOpenGL3dReference >> transformedObject [ 

	^ transformedObject ifNil: [ transformedObject := self applyTransformationTo: object ]
]

{ #category : #accessing }
JunOpenGL3dReference >> translation: aJun3dPoint [

	translation := aJun3dPoint.
	self 
		flushBounds ; 
		flushTransformedObject
]

{ #category : #'vrml support' }
JunOpenGL3dReference >> vrml10On: aStream [ 

	self transformedObject vrml10On: aStream
]

{ #category : #'vrml support' }
JunOpenGL3dReference >> vrml20On: aStream [ 

	self transformedObject vrml20On: aStream
]
