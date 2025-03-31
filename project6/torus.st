Shape subclass: Torus [
    | smallRadius largeRadius pi |
    <comment: 'I represent a sphere with radius and pi as attributes.'>

    Torus class >> new: shapeName smallRadius: s largeRadius: l [
        <category: 'instance creation'>
        | newTorus |
        newTorus := super new.
        newTorus init: shapeName smallRadius: s largeRadius: l.
        ^ newTorus
    ]

    init: shapeName smallRadius: s largeRadius: l [
        <category: 'initialization'>
        smallRadius := s.
        largeRadius := l.
        pi := 3.14159265358979323846.
        super init: shapeName
    ]

    getArea [
        <category: 'calculations'>
        ^ (2 * pi * largeRadius) + (2 * pi * smallRadius)
    ]

    getVolume [
        <category: 'calculations'>
        ^ (pi * smallRadius * smallRadius) * (2 * pi * largeRadius)
    ]
]