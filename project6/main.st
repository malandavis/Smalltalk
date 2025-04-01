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

    Main class >> count: shapeList [
        | counter |
        counter := 0.
        shapeList do: [:eachShape | counter := counter + 1].
        Transcript
            show: 'There are ', counter printString, ' shapes.';
            cr.
    ]

    Main class >> min: shapeList [
        (shapeList isEmpty) ifTrue: [Transcript show: 'There are no shapes that satisfy the condition(s).'; cr.]
        ifFalse: [
            | minArea minVolume |
            minArea := shapeList first getArea.
            minVolume := shapeList first getVolume.
            shapeList do: [:eachShape |
                (eachShape getArea < minArea) ifTrue: [minArea := eachShape getArea.].
                (eachShape getVolume < minVolume) ifTrue: [minVolume := eachShape getVolume.].
            ].
            Transcript
                show: 'min(Surface Area)=', minArea printString;
                cr;
                show: 'min(Volume)=', minVolume printString;
                cr.
        ].
    ]

    Main class >> max: shapeList [
        (shapeList isEmpty) ifTrue: [Transcript show: 'There are no shapes that satisfy the condition(s).'; cr.]
        ifFalse: [
            | maxArea maxVolume |
            maxArea := shapeList first getArea.
            maxVolume := shapeList first getVolume.
            shapeList do: [:eachShape |
                (eachShape getArea > maxArea) ifTrue: [maxArea := eachShape getArea.].
                (eachShape getVolume > maxVolume) ifTrue: [maxVolume := eachShape getVolume.].
            ].
            Transcript
                show: 'max(Surface Area)=', maxArea printString;
                cr;
                show: 'max(Volume)=', maxVolume printString;
                cr.
        ].
    ]

    Main class >> avg: shapeList [
        (shapeList isEmpty) ifTrue: [Transcript show: 'There are no shapes that satisfy the condition(s).'; cr.]
        ifFalse: [
            | totalArea totalVolume counter |
            totalArea := 0.0.
            totalVolume := 0.0.
            counter := 0.
            shapeList do: [:eachShape |
                totalArea := totalArea + (eachShape getArea).
                totalVolume := totalVolume + (eachShape getVolume).
                counter := counter + 1.
            ].
            Transcript
                show: 'avg(Surface Area)=', (totalArea / counter) printString;
                cr;
                show: 'avg(Volume)=', (totalVolume / counter) printString;
                cr.
        ].
    ]

    Main class >> total: shapeList [
        (shapeList isEmpty) ifTrue: [Transcript show: 'There are no shapes that satisfy the condition(s).'; cr.]
        ifFalse: [
            | totalArea totalVolume counter |
            totalArea := 0.0.
            totalVolume := 0.0.
            shapeList do: [:eachShape |
                totalArea := totalArea + (eachShape getArea).
                totalVolume := totalVolume + (eachShape getVolume).
            ].
            Transcript
                show: 'total(Surface Area)=', totalArea printString;
                cr;
                show: 'total(Volume)=', totalVolume printString;
                cr.
        ].
    ]

    Main class >> splitAtFirstNumber: aString [
        | index |
        index := aString findFirst: [:char | char isDigit].
        index = 0 ifTrue: [ ^aString ].
        ^{
            aString copyFrom: 1 to: index - 1.
            (aString copyFrom: index to: aString size) asNumber.
        }.
    ]

    Main class >> checkConditions: passedList count: num [
        | cond conditions success shapeList newList |
        shapeList := passedList.
        cond := 0.
        [ cond < num ] whileTrue: [
            Transcript show: 'Enter condition #', (cond + 1) printString, ': '.
            conditions := stdin nextLine substrings: ' '.
            success := 1.

            (#('type' 'area' 'volume') includes: (conditions first)) ifFalse: [
                Transcript show: conditions first, ': invalid column.'; cr.
                success := 0.
            ].
            (#('<' '>' '<=' '>=' '==' '!=') includes: (conditions second)) ifFalse: [
                Transcript show: conditions second, ': invalid operator.'; cr.
                success := 0.
            ].

            (success = 1) ifTrue: [
                (conditions first = 'volume') ifTrue: [
                    newList := OrderedCollection new.
                    shapeList do: [:eachShape |
                        (Main operation: (eachShape getVolume) value: conditions second value: (conditions third asNumber asFloat)) ifTrue: [ newList add: eachShape ].
                    ].
                    shapeList := newList.
                ] ifFalse: [
                    (conditions first = 'area') ifTrue: [
                        newList := OrderedCollection new.
                        shapeList do: [:eachShape |
                            (Main operation: (eachShape getArea) value: conditions second value: (conditions third asNumber asFloat)) ifTrue: [ newList add: eachShape ].
                        ].
                        shapeList := newList.
                    ] ifFalse: [
                        (conditions first = 'type') ifTrue: [
                            newList := OrderedCollection new.
                            shapeList do: [:eachShape |
                                (Main operation: (eachShape getType) value: conditions second value: conditions third) ifTrue: [ newList add: eachShape ].
                            ].
                            shapeList := newList.
                        ].
                    ].
                ].

                cond := cond + 1.
            ].
        ].

        ^ shapeList.
    ]

    Main class >> operation: a value: op value: b[
        ('>' = op) ifTrue: [ ^(a > b)].
        ('>=' = op) ifTrue: [ ^(a >= b)].
        ('<' = op) ifTrue: [ ^(a < b)].
        ('<=' = op) ifTrue: [ ^(a <= b)].
        ('==' = op) ifTrue: [ ^(a = b)].
        ('!=' = op) ifTrue: [ ^(a ~= b)].
    ]

    " Main class >> checkVolume: shapeList operator: op value: val [
        | newList |
        newList := OrderedCollection new.
        shapeList do: [:eachShape |
            (Main operation: (eachShape getVolume) value: op value: (val asNumber asFloat)) ifTrue: [ newList add: eachShape ].
        ].
        ^ newList.
    ] "

    Main class >> printShapes: shapeList [
        shapeList do: [:eachShape | 
            eachShape printDetails.
        ]. 
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
            (shapes isEmpty) ifTrue: [
                Transcript show: 'There are no shapes in the file'; cr.
                success := 0.
            ].
        ].
].

(success = 1) ifTrue: [
    | commandList |
    Transcript show: 'Enter a command: '.
    userInput := stdin nextLine.
    [ userInput = 'quit' ] whileFalse: [
        (#('count' 'min' 'max' 'avg' 'total' 'help' 'print') includes: userInput) ifTrue: [
            userInput = 'help' ifTrue: [ Main printHelp. ].
            userInput = 'print' ifTrue: [ Main printShapes: shapes ].
            userInput = 'count' ifTrue: [ Main count: shapes. ].
            userInput = 'min' ifTrue: [ Main min: shapes. ].
            userInput = 'max' ifTrue: [ Main max: shapes. ].
            userInput = 'avg' ifTrue: [ Main avg: shapes. ].
            userInput = 'total' ifTrue: [ Main total: shapes. ].
        ] ifFalse: [
            commandList := Main splitAtFirstNumber: userInput.
            (#('count' 'min' 'max' 'avg' 'total' 'help' 'print') includes: (commandList first)) ifTrue: [
                " Transcript
                    show: 'New commands: ', commandList first;
                    show: ' and ', commandList second printString; cr. "
                condList := Main checkConditions: shapes count: (commandList second asNumber).
                (commandList first = 'count') ifTrue: [ Main count: condList ].
                (commandList first = 'min') ifTrue: [ Main min: condList ].
                (commandList first = 'avg') ifTrue: [ Main avg: condList ].
                (commandList first = 'total') ifTrue: [ Main total: condList ].
                (commandList first = 'print') ifTrue: [ Main printShapes: condList ].
            ].
        ].
        
        
        Transcript show: 'Enter a command: '.
        userInput := stdin nextLine.
    ].
].


