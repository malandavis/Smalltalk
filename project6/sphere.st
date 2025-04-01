Shape subclass: Sphere [
    | radius pi |
    <comment: 'I represent a sphere with radius and pi as attributes.'>

    Sphere class >> new: shapeName radius: r [
        <category: 'instance creation'>
        | newSphere |
        newSphere := super new.
        newSphere init: shapeName radius: r.
        ^ newSphere
    ]

    init: shapeName radius: r [
        <category: 'initialization'>
        radius := r.
        pi := 3.14159265358979323846.
        super init: shapeName
    ]

    getArea [
        <category: 'calculations'>
        ^ 4 * pi * radius * radius
    ]

    getVolume [
        <category: 'calculations'>
        ^ (4 / 3) * pi * radius * radius * radius
    ]

    getType [ ^'sphere' ]

    printDetails [
        Transcript
            show: 'Sphere: ', self getName;
            show: ', Radius=', radius printString;
            cr;
            tab;
            show: 'Surface Area: ', self getArea printString;
            show: ', Volume: ', self getVolume printString;
            cr.
    ]
]
