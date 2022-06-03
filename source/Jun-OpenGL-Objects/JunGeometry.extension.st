Extension { #name : #JunGeometry }

{ #category : #'*Jun-OpenGL-Objects' }
JunGeometry >> asJunOpenGL3dPolylines [
	"((0 , 0 , 0 box: 1 , 2 , 3) asJunOpenGL3dPolylines) show."

	| aBody |
	aBody := JunOpenGL3dCompoundObject new.
	self asArrayOfLines 
		do: [:aLine | aBody add: (JunOpenGL3dPolyline with: aLine first with: aLine last)].
	^aBody
]

{ #category : #'*Jun-OpenGL-Objects' }
JunGeometry >> showWithArrows [
	"(0 , 0 box: 1 , 1) showWithArrows."

	"(0 , 0 , 0 box: 1 , 1 , 1) showWithArrows."

	| arrowObject |
	self is2d 
		ifTrue: [arrowObject := JunOpenGL3dObject xyArrows]
		ifFalse: [arrowObject := JunOpenGL3dObject xyzArrows].
	^((self asJunOpenGL3dObject asCompoundObject)
		add: arrowObject;
		yourself) show
]

{ #category : #'*Jun-OpenGL-Objects' }
JunGeometry >> showWithUnitArrows [
	"(0 , 0 box: 1 , 1) showWithUnitArrows."

	"(0 , 0 , 0 box: 1 , 1 , 1) showWithUnitArrows."

	| arrowObject |
	self is2d 
		ifTrue: [arrowObject := JunOpenGL3dObject xyUnitArrows]
		ifFalse: [arrowObject := JunOpenGL3dObject xyzUnitArrows].
	^((self asJunOpenGL3dObject asCompoundObject)
		add: arrowObject;
		yourself) show
]
