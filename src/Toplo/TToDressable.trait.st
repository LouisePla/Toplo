Trait {
	#name : #TToDressable,
	#instVars : [
		'skin',
		'skinType'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing dresser' }
TToDressable >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - initialization dresser' }
TToDressable >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser: aDresser [

	| currentDresser |
	currentDresser := self userData at: #dresser ifAbsent:[ nil ].
	(currentDresser notNil and:[ currentDresser = aDresser ]) ifTrue:[ ^ self ].

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d | d launchInstallationIn: self ]
	
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - initialization dresser' }
TToDressable >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - initialization dresser' }
TToDressable >> postInitializeDresser [
	"Called after dresser initialization"
	
]

{ #category : #'t - initialization dresser' }
TToDressable >> preInitializeDresser [
	"Called before dresser initialization"
	
]

{ #category : #'t - accessing dresser' }
TToDressable >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

{ #category : #'t - accessing dresser' }
TToDressable >> undress [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: nil
]
