Object subclass: Shape [
    | name |

    Shape class >> new: shapeName [
        | newShape |
        newShape := super new.
        newShape init: shapeName.
        ^ newShape
    ]

    init: shapeName [
        name := shapeName.
    ]

    getName [
        ^ name
    ]

    getArea [
        ^ 0. "Subclasses should override this"
    ]

    getVolume [
        ^ 0. "Subclasses should override this"
    ]
]
