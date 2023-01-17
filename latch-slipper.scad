module poly3d(verts) {
  linear_extrude(height = 1) { polygon(verts); }
}

difference() {
  // The card
  cube([ 85, 53, 1 ]);

  // The cutout shape
  translate([ 30, 0, 0 ]) {
    scale([ 30, 30, 10 ]) {
      union() {
        // Left wedge
        poly3d([ [ 0, 0 ], [ 1, 0 ], [ 1, 1 ] ]);

        // Right slice
        difference() {
          // Tall slice
          translate([ 1, 0, 0 ]) { cube([ 0.5, 1, 1 ]); }

          // Corner nips
          scale([ 1, 1, 1.25 ]) {
            poly3d([ [ 1.25, 1 ], [ 1.5, 1 ], [ 1.5, 0.85 ] ]);
          }
        }

        // Bottom right point
        poly3d([ [ 1.25, 0.3 ], [ 1.6, 0 ], [ 1.25, 0 ] ]);
      }
    }
  }

  // Keyring hole
  translate([ 7, 47, -0.5 ]) { cylinder(h = 2, r = 3); }

  // Material removal shapes
  // translate([ 0, 0, 0.5 ]) {
  //   union() {
  //     polygon([ [ 10, 10 ], [ 10, 20 ], [ 40, 20 ] ]);
  //     polygon([ [ 10, 5 ], [ 30, 5 ], [ 30, 12.5] ]);
  //   }
  // }
}