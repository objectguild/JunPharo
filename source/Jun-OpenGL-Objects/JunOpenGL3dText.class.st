Class {
	#name : #JunOpenGL3dText,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'point',
		'height',
		'string',
		'rotation',
		'styleName'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #enumerating }
JunOpenGL3dText >> geometriesDo: aBlock [ 

	aBlock value: point
]

{ #category : #accessing }
JunOpenGL3dText >> height: aNumber [ 

	height := aNumber
]

{ #category : #utilities }
JunOpenGL3dText >> numberOfPolygons [

	^ 0
]

{ #category : #utilities }
JunOpenGL3dText >> numberOfPolylines [

	^ 0
]

{ #category : #accessing }
JunOpenGL3dText >> point: aJun3dPoint [

	point := aJun3dPoint 
]

{ #category : #printing }
JunOpenGL3dText >> printOn: aStream [ 

	aStream nextPutAll: string
]

{ #category : #rendering }
JunOpenGL3dText >> renderOn: aRenderingContext [ 

	self error: 'Currently not supported: ' , thisContext methodSelector printString
]

{ #category : #converting }
JunOpenGL3dText >> reversed [

	^ self copy
]

{ #category : #accessing }
JunOpenGL3dText >> rotation: aNumber [ 

	rotation := aNumber
]

{ #category : #accessing }
JunOpenGL3dText >> string: aString [ 

	string := aString
]

{ #category : #accessing }
JunOpenGL3dText >> styleName: aString [ 

	styleName := aString
]

{ #category : #'lisp support' }
JunOpenGL3dText >> toLispList [

	self error: 'Currently not supported: ' , thisContext methodSelector printString
]

{ #category : #transforming }
JunOpenGL3dText >> transform: aTransformation [ 

	"Currently not supported"

	^ self copy
]

{ #category : #'vrml support' }
JunOpenGL3dText >> vrml10On: aStream [ 

	"Currently not supported"
]

{ #category : #'vrml support' }
JunOpenGL3dText >> vrml20On: aStream [ 

	"Currently not supported"
]
