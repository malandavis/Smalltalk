| shapes success |

success := 0.

Object subclass: Main [
    Main class >> loadShapes: fileName [
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

    Main class >> printHelp [
        Transcript
            show: '	count'; cr;
            show: '	*** print the number of all shapes'; cr;
            show: '	countN'; cr;
            show: '	*** print the number of all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: count3'; cr;
            show: '	print'; cr;
            show: '	*** print all shapes'; cr;
            show: '	printN'; cr;
            show: '	*** print all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: print4'; cr;
            show: '	min'; cr;
            show: '	*** find the minimum surface area and volume of all shapes'; cr;
            show: '	minN'; cr;
            show: '	*** find the minimum surface area and volume of all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: min2'; cr;
            show: '	max'; cr;
            show: '	*** find the maximum surface area and volume of all shapes'; cr;
            show: '	maxN'; cr;
            show: '	*** find the maximum surface area and volume of all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: max3'; cr;
            show: '	total'; cr;
            show: '	*** find the total surface area and volume of all shapes'; cr;
            show: '	totalN'; cr;
            show: '	*** find the total surface area and volume of all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: total4'; cr;
            show: '	avg'; cr;
            show: '	*** find the average surface area and volume of all shapes'; cr;
            show: '	avgN'; cr;
            show: '	*** find the average surface area and volume of all shapes that satisfy all N conditions specified below'; cr;
            show: '	*** for example: avg2'; cr;
            show: '	quit'; cr;
            show: '	*** quit this program'; cr;
            show: '	help'; cr;
            show: '	*** print this list'; cr;
            cr;
            show: 'Each condition shall be entered in one line and of the following format:'; cr;
            cr;
            show: '	name op value'; cr;
            cr;
            show: '	*** for example: type != box'; cr;
            show: '	                 area <= 1000'; cr;
            show: '	                 volume > 100.5'; cr;
            cr;
            show: '	The valid names:'; cr;
            show: '		type'; cr;
            show: '		area'; cr;
            show: '		volume'; cr;
            cr;
            show: '	The valid operators:'; cr;
            show: '		=='; cr;
            show: '		!='; cr;
            show: '		<'; cr;
            show: '		<='; cr;
            show: '		>'; cr;
            show: '		>='; cr;
            cr.
    ]
].


(Smalltalk arguments isEmpty) ifTrue: [
    Transcript show: 'Error: No filename specified. Usage:gst shape.st sphere.st cylinder.st torus.st box.st -f main.st <filename>'; cr.
] ifFalse: [
        fileName := Smalltalk arguments first.
        ((File name: fileName) exists) ifFalse: [
            Transcript show: 'Error: '; print: fileName; show: ' does not exist.'; cr.
        ] ifTrue: [
            shapes := Main loadShapes: (Smalltalk arguments first).
            success := 1.
        ].
].

(success = 1) ifTrue: [
    Transcript show: 'Enter a command: '.
    userInput := stdin nextLine.
    [ userInput = 'quit' ] whileFalse: [
        userInput = 'help' ifTrue: [ Main printHelp. ].
        
        
        Transcript show: 'Enter a command: '.
        userInput := stdin nextLine.
    ].
].


