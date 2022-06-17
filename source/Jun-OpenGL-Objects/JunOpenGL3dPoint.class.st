Class {
	#name : #JunOpenGL3dPoint,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'point'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #enumerating }
JunOpenGL3dPoint >> geometriesDo: aBlock [

	aBlock value: point
]

{ #category : #utilities }
JunOpenGL3dPoint >> numberOfPolygons [

	^ 0
]

{ #category : #utilities }
JunOpenGL3dPoint >> numberOfPolylines [

	^ 0
]

{ #category : #accessing }
JunOpenGL3dPoint >> point [

	^ point
]

{ #category : #accessing }
JunOpenGL3dPoint >> point: aJun3dPoint [

	point := aJun3dPoint 
]

{ #category : #rendering }
JunOpenGL3dPoint >> renderOn: aRenderingContext [

	"Not implemented"
]

{ #category : #converting }
JunOpenGL3dPoint >> reversed [

	^ self copy
]

{ #category : #'lisp support' }
JunOpenGL3dPoint >> toLispList [

	self error: 'Currently not supported: ' , thisContext methodSelector printString
]

{ #category : #transforming }
JunOpenGL3dPoint >> transform: aTransformation [

	"Currently not supported"

	^ self copy
]

{ #category : #'vrml support' }
JunOpenGL3dPoint >> vrml10On: aStream [

	"Currently not supported"
]

{ #category : #'vrml support' }
JunOpenGL3dPoint >> vrml20On: aStream [

	"Currently not supported"
]
