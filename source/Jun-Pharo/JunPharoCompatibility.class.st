Class {
	#name : #JunPharoCompatibility,
	#superclass : #Object,
	#category : #'Jun-Pharo-Support'
}

{ #category : #'class initialization' }
JunPharoCompatibility class >> install [ 

	<script>

	Smalltalk globals at: #Double put: Float
]
