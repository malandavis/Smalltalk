Shape subclass: Box [
    | length width height |

    Box class >> new: shapeName length: l width: w height: h [
        | newBox |
        newBox := super new. "Calls Shape's new method"
        newBox init: shapeName length: l width: w height: h.  "Now we correctly call the init: method"
        ^ newBox
    ]

    init: shapeName length: l width: w height: h [
        length := l.
        width := w.
        height := h.
        super init: shapeName.  "Initialize the name via the Shape class"
    ]

    getArea [
        ^ (2 * length * width) + (2 * width * height) + (2 * length * height)
    ]

    getVolume [
        ^ length * width * height
    ]

    getType [ ^'box' ]

    printDetails [
        Transcript
            show: 'Box: ', self getName;
            show: ', Length=', (Main trunc: length);
            show: ', Width=', (Main trunc: width);
            show: ', Height=', (Main trunc: height);
            cr;
            tab;
            show: 'Surface Area: ', (Main trunc: self getArea);
            show: ', Volume: ', (Main trunc: self getVolume);
            cr.
    ]
]
