/* gamma-sRGB.pov
 * Persistence of Vision Raytracer scene description file
 *
 * Tests the examples in the Gamma-sRGB tutorial.
 *
 * Copyright © 2022, 2024 Richard Callwood III.  Some rights reserved, under
 * a Creative Commons Attribution-ShareAlike 4.0 International license.
 *
 * 2022-Jul-01  Created.
 * 2024-Apr-16  The Dutch flag colors are updated, and the scene is prepared
 *              for public release.
 */
// +W512 +H256
#version 3.7;

global_settings { assumed_gamma 1 } // Step 1

#include "colors.inc"

background { rgb 1/6 }

camera
{ location <200, 20, -200>
  look_at <0, 20, 0>
  right 2 * x
  up y
  angle 40
}

plane { y, 0 pigment { White } }

// Dutch flag colors:
// The byte values were calculated directly from the official Dutch xyY specs.
box
{ <-1, 0, -1>, <1, 2, 1> scale 1/2
  pigment
  { gradient y color_map
    { [1/3 srgb <32, 71, 133> / 255] // Steps 2 & 3
      [1/3 White]
      [2/3 White]
      [2/3 srgb <170, 28, 38> / 255] // Steps 2 & 3
    }
  }
  scale 40
}

// Orange light source:
#declare C = srgb <1, 0.5, 0>; // This must be declared separately! (step 3)
#declare Ld = 100; // light distance
#declare Fd = 1; // fade distance
light_source
{ <100, 50, 0>,
  C * (1 + pow (Ld/Fd, 2)) / 2 // Step 4: math is applied to identifier C
  fade_power 2
  fade_distance Fd
}

light_source
{ <0, 50, -100>, rgb (1 + pow (Ld/Fd, 2)) / 2
  fade_power 2
  fade_distance Fd
}
