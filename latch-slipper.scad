// This file defines a credit card sized door latch slipping tool.
// Design by: Evan Pratten <evan@ewpratten.com>
//
// Notes:
// - All units are in millimeters

module poly3d(verts) {
  linear_extrude(height = 1) { polygon(verts); }
}

module unit_dual_tris() {
  union() {
    poly3d([ [ 0, 0.125 ], [ 0, 1 ], [ 0.875, 1 ] ]);
    poly3d([ [ 0.125, 0 ], [ 1, 0 ], [ 1, 0.875 ] ]);
  }
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
  translate([ 2.5, 35, 0 ]) {
    // cylinder(h = 2, r = 3);
    cube([ 7.5, 15, 1 ]);
  }

  // Material removal shapes
  union() {
    poly3d([
      [ 0, 0 ],
      [ 60, 0 ],
      [ 60, 30 ],
      [ 0, 30 ],
    ]);

    // Triangle mesh cutouts
    translate([ 12.5, 35, 0 ]) {
      scale([ 15, 15, 1 ]) {
        // Left triangle
        unit_dual_tris();

        // Middle triangle
        translate([ 1.25, 0, 0 ]) {
          translate([ 1, 0, 0 ]) {
            rotate(a = 90, v = [ 0, 0, 1 ]) { unit_dual_tris(); }
          }
        }

        // Right triangle
        translate([ 2.5, 0, 0 ]) { unit_dual_tris(); }
      }
    }

    // Top right structural triangles
    translate([ 67.5, 35, 0 ]) {
      scale([ 15, 15, 1 ]) {
        union() {
          poly3d([ [ 0, 0.5 ], [ 1, 1 ], [ 1, 0 ] ]);
          poly3d([ [ 0, 0 ], [ 0, 0.25 ], [ 0.6, 0 ] ]);
          poly3d([ [ 0, 1 ], [ 0, 0.75 ], [ 0.6, 1 ] ]);
        }
      }
    }
  }
}