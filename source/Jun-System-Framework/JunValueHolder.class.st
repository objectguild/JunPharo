"
Imported by VwImportClass
"
Class {
	#name : #JunValueHolder,
	#superclass : #ValueHolder,
	#category : #'Jun-System-Framework'
}

{ #category : #copyright }
JunValueHolder class >> copyright [
	^'Jun799 (2015/09/19) Copyleft 1996-2015 AOKI Atsushi, ODA Tomohiro, HOSHI Takanori, NISHINAKA Yoshiyuki, YAMADA Ryousuke, WATANABE Katsuhiro, Ankur J. Chavda, NISHIHARA Satoshi, MATSUDA Ryouichi, MATSUO Minoru, Brent N. Reeves, ASAOKA Hiroko, TANAKA Shinichi, ASADA Mitsuhiro, Paul Guyot (LIP6), Albert Kerssies, MATSUBARA Nobuto, SAWAMOTO Eri, HAYASHI Koichiro, NAKAO Tatsuya, and NISHIMURA Yuuri.'
]

{ #category : #examples }
JunValueHolder class >> example1 [
	"JunValueHolder example1."

	| valueWheel horizontalWheel verticalWheel |
	valueWheel := JunValueHolder with: 0.
	valueWheel compute: 
			[:aValue | 
			Transcript
				cr;
				show: 'Wheel: ' , aValue printString].
	horizontalWheel := JunThumbWheel horizontal.
	horizontalWheel compute: [:aValue | valueWheel value: aValue].
	verticalWheel := JunThumbWheel vertical.
	verticalWheel compute: [:aValue | valueWheel value: aValue].
	valueWheel compute: [:aValue | horizontalWheel angularValue: aValue].
	valueWheel compute: [:aValue | verticalWheel angularValue: aValue].
	horizontalWheel openIn: (100 @ 300 extent: 160 @ 160).
	verticalWheel openIn: (300 @ 300 extent: 160 @ 160).
	horizontalWheel closeTogether: verticalWheel.
	verticalWheel closeTogether: horizontalWheel.
	^Array 
		with: valueWheel
		with: horizontalWheel
		with: verticalWheel
]

{ #category : #examples }
JunValueHolder class >> example2 [
	"JunValueHolder example2."

	| valueGauge firstGauge secondGauge |
	valueGauge := JunValueHolder with: 0.
	valueGauge compute: 
			[:aValue | 
			Transcript
				cr;
				show: 'Gauge: ' , aValue printString].
	firstGauge := JunGaugeModel value: 50.
	firstGauge compute: [:aValue | valueGauge value: aValue].
	secondGauge := JunGaugeModel value: 50.
	secondGauge compute: [:aValue | valueGauge value: aValue].
	valueGauge compute: [:aValue | firstGauge value: aValue].
	valueGauge compute: [:aValue | secondGauge value: aValue].
	firstGauge openIn: (100 @ 300 extent: 160 @ 160).
	secondGauge openIn: (300 @ 300 extent: 160 @ 160).
	firstGauge closeTogether: secondGauge.
	secondGauge closeTogether: firstGauge.
	^Array 
		with: valueGauge
		with: firstGauge
		with: secondGauge
]

{ #category : #examples }
JunValueHolder class >> example3 [
	"JunValueHolder example3."

	| valueWheel horizontalWheel verticalWheel valueGauge firstGauge secondGauge anArray |
	valueWheel := JunValueHolder with: 0.
	valueWheel compute: 
			[:aValue | 
			Transcript
				cr;
				show: 'Wheel: ' , aValue printString].
	horizontalWheel := JunThumbWheel horizontal.
	horizontalWheel compute: [:aValue | valueWheel value: aValue].
	verticalWheel := JunThumbWheel vertical.
	verticalWheel compute: [:aValue | valueWheel value: aValue].
	valueWheel compute: [:aValue | horizontalWheel angularValue: aValue].
	valueWheel compute: [:aValue | verticalWheel angularValue: aValue].
	valueGauge := JunValueHolder with: 0.
	valueGauge compute: 
			[:aValue | 
			Transcript
				cr;
				show: 'Gauge: ' , aValue printString].
	firstGauge := JunGaugeModel value: 0 range: #(-100 100 10 1).
	firstGauge compute: [:aValue | valueGauge value: aValue].
	secondGauge := JunGaugeModel value: 0 range: #(-100 100 10 1).
	secondGauge compute: [:aValue | valueGauge value: aValue].
	valueGauge compute: [:aValue | firstGauge value: aValue].
	valueGauge compute: [:aValue | secondGauge value: aValue].
	valueWheel 
		compute: [:aValue | valueGauge value: (-100 max: (valueGauge value + aValue min: 100))].
	horizontalWheel openIn: (100 @ 300 extent: 160 @ 160).
	verticalWheel openIn: (300 @ 300 extent: 160 @ 160).
	firstGauge openIn: (100 @ 500 extent: 160 @ 160).
	secondGauge openIn: (300 @ 500 extent: 160 @ 160).
	anArray := Array 
				with: horizontalWheel
				with: verticalWheel
				with: firstGauge
				with: secondGauge.
	anArray do: [:each | each closeTogether: anArray]
]

{ #category : #copyright }
JunValueHolder class >> system [
	^'Jun'
]

{ #category : #copyright }
JunValueHolder class >> version [
	^'799'
]

{ #category : #accessing }
JunValueHolder >> value: aValue [ 
	| aContext aBlock |
	aContext := thisContext.
	aBlock := nil.
	aBlock := 
			[:context | 
			(aContext receiver == context receiver 
				and: [aContext selector == context selector]) 
					ifTrue: 
						[self setValue: aValue.
						^self].
			context sender isNil ifFalse: [aBlock value: context sender]].
	aBlock value: aContext sender.
	self setValue: aValue.
	self changed: #value
]
