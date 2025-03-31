| shapes success |

success := 0.

Object subclass: ShapeLoader [
    ShapeLoader class >> loadShapes: fileName [
        | classShapes stream line parts myBox myCylinder mySphere myTorus |
        classShapes := OrderedCollection new.
        stream := FileStream open: fileName mode: 'r'.
        [
            [ stream atEnd ] whileFalse: [
                line := stream nextLine.
                parts := line substrings: ' '.
                (parts second = 'box') 
                    ifTrue: [ 
                        myBox := Box
                            new: parts first
                            length: (parts at: 3) asNumber asFloat
                            width: (parts at: 4) asNumber asFloat
                            height: (parts at: 5) asNumber asFloat.
                        classShapes add: myBox.
                    ].
                (parts second = 'cylinder') 
                    ifTrue: [ 
                        myCylinder := Cylinder
                            new: parts first
                            radius: (parts at: 3) asNumber asFloat
                            height: (parts at: 4) asNumber asFloat.
                        classShapes add: myCylinder.
                    ].
                (parts second = 'sphere') 
                    ifTrue: [ 
                        mySphere := Sphere
                            new: parts first
                            radius: (parts at: 3) asNumber asFloat.
                        classShapes add: mySphere.
                    ].
                (parts second = 'torus') 
                    ifTrue: [ 
                        myTorus := Torus
                            new: parts first
                            smallRadius: (parts at: 3) asNumber asFloat
                            largeRadius: (parts at: 4) asNumber asFloat.
                        classShapes add: myTorus.
                    ].
            ] 
        ] ensure: [
            stream close.
        ].
    ^ classShapes.
    ]
].


(Smalltalk arguments isEmpty) ifTrue: [
    Transcript show: 'Error: No filename specified. Usage:gst shape.st sphere.st cylinder.st torus.st box.st -f main.st <filename>'; cr.
] ifFalse: [
        "Check if file exists - GNU Smalltalk way"
        fileName := Smalltalk arguments first.
        ((File name: fileName) exists) ifFalse: [
            Transcript show: 'Error: '; print: fileName; show: ' does not exist.'; cr.
        ] ifTrue: [
            shapes := ShapeLoader loadShapes: (Smalltalk arguments first).
            Transcript print: (shapes at: 2) getArea; cr.
            success := 1.
        ].
].

(success = 1) ifTrue: [
    Transcript show: 'succesfully loaded shapes!'; cr.
]



