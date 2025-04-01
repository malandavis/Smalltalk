Shape subclass: Cylinder [
    | radius height pi |
    <comment: 'I represent a sphere with radius and pi as attributes.'>

    Cylinder class >> new: shapeName radius: r height: h [
        <category: 'instance creation'>
        | newCylinder |
        newCylinder := super new.
        newCylinder init: shapeName radius: r height: h.
        ^ newCylinder
    ]

    init: shapeName radius: r height: h [
        <category: 'initialization'>
        radius := r.
        height := h.
        pi := 3.14159265358979323846.
        super init: shapeName
    ]

    getArea [
        <category: 'calculations'>
        ^ (2.0 * pi * radius * radius) + (2.0 * pi * radius * height)
    ]

    getVolume [
        <category: 'calculations'>
        ^ radius * pi * radius * height
    ]

    getType [ ^'cylinder' ]

    printDetails [
        Transcript
            show: 'Cylinder: ', self getName;
            show: ', Radius=', (Main trunc: radius);
            show: ', Height=', (Main trunc: height);
            cr;
            tab;
            show: 'Surface Area: ', (Main trunc: self getArea);
            show: ', Volume: ', (Main trunc: self getVolume);
            cr.
    ]
]
