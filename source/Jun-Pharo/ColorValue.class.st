Class {
	#name : #ColorValue,
	#superclass : #Color,
	#category : #'Jun-Pharo-Support'
}

{ #category : #'as yet unclassified' }
ColorValue >> blendWith: aColor [ 

	^ self mixed: 0.5 with: aColor
]
