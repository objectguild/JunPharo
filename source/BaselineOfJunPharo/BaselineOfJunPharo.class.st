Class {
	#name : #BaselineOfJunPharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfJunPharo
}

{ #category : #baselines }
BaselineOfJunPharo >> baseline: spec [
	<baseline>

	spec for: #common do: [ 

		spec postLoadDoIt: #postload:package:.

		"Dependencies"

		"Packages"
		spec 
			package: 'Jun-Collections-Hash' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Collections-Sequences' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-DXF-Support' with: [ spec requires: #( 'Jun-System-Framework' 'Jun-Geometry-Basic' 'Jun-Geometry-Boundaries' 'Jun-Geometry-Curves' 'Jun-Geometry-Transformations' 'Jun-OpenGL-Display' 'Jun-OpenGL-Objects' ) ] ;
			package: 'Jun-Geometry-Abstract' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Basic' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Boundaries' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Curves' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Forms' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Pluralities' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Solid' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Surfaces' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Geometry-Transformations' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Goodies-Lisp' with: [ spec requires: #( 'Jun-System-Framework' ) ] ;
			package: 'Jun-Goodies-Tables' with: [ spec requires: #( 'Jun-System-Framework' 'Jun-Goodies-Lisp' ) ] ;
			package: 'Jun-OpenGL-Display' with: [ spec requires: #( 'Jun-System-Framework' 'Jun-OpenGL-Objects' ) ] ;
			package: 'Jun-OpenGL-Objects' with: [ spec requires: #( 'Jun-System-Framework' 'Jun-Collections-Hash' 'Jun-Collections-Sequences' 'Jun-Geometry-Abstract' 'Jun-Geometry-Basic' 'Jun-Geometry-Boundaries' 'Jun-Geometry-Curves' 'Jun-Geometry-Forms' 'Jun-Geometry-Surfaces' 'Jun-Geometry-Transformations' 'Jun-Goodies-Lisp' 'Jun-Goodies-Tables' 'Jun-OpenGL-Display' ) ] ;
			package: 'Jun-Pharo' ;
			package: 'Jun-System-Framework' with: [ spec requires: #( 'Jun-Pharo' ) ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' 'Tests' );

			group: 'Core' with: #( 'Jun-Geometry-Basic' 'Jun-Geometry-Boundaries' 'Jun-Geometry-Curves' 'Jun-Geometry-Solid' 'Jun-Geometry-Surfaces' 'Jun-Geometry-Transformations' );
			group: 'DXF' with: #( 'Jun-DXF-Support' );
			group: 'Tests' with: #( );

			group: 'CI' with: #( 'Tests' );

			group: 'Development' with: #( 'Core' 'Tests' );
			group: 'Production' with: #( 'Core' )
	 ] 
]
