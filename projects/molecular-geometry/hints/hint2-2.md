To build the distance matrix, we need a loop for each index:
```c++
  ...
  #include <cmath>
  ...
  
  for(int i=0; i < mol.natom; i++) {
    for(int j=0; j < mol.natom; j++) {
        R[i][j] = sqrt( (mol.geom[i][0]-mol.geom[j][0])*(mol.geom[i][0]-mol.geom[j][0])
                      + (mol.geom[i][1]-mol.geom[j][1])*(mol.geom[i][1]-mol.geom[j][1])
                      + (mol.geom[i][2]-mol.geom[j][2])*(mol.geom[i][2]-mol.geom[j][2]) );
    }
  }
```
Note also that the `sqrt()` function is part of the C math library; thus we need the `#include <cmath>` directive.
