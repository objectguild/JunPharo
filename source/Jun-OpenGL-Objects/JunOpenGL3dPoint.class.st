Class {
	#name : #JunOpenGL3dPoint,
	#superclass : #JunOpenGL3dPrimitiveObject,
	#instVars : [
		'point',
		'thickness',
		'angle'
	],
	#category : #'Jun-OpenGL-Objects'
}

{ #category : #accessing }
JunOpenGL3dPoint >> angle [ 

	"Added to support DXF point entity.

	Angle of the X axis for the User Coordinate System (UCS) in effect when the point was drawn."
	
	^ angle
]

{ #category : #accessing }
JunOpenGL3dPoint >> angle: aNumber [

	angle := aNumber 
]

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

{ #category : #accessing }
JunOpenGL3dPoint >> thickness [ 

	^ thickness 
]

{ #category : #accessing }
JunOpenGL3dPoint >> thickness: aNumber [

	thickness := aNumber 
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
