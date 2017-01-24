Be careful about the diagonal elements of the unit vector matrices because of the division by the bond distance between atoms i and j.  You should restrict the loops to skip those elements involving a divide-by-zero condition!
```c++
  for(i=0; i < mol.natom; i++) {
    for(j=0; j < i; j++) {
      ex[i][j] = ex[j][i] = -(x[i] - x[j])/R[i][j];
      ey[i][j] = ey[j][i] = -(y[i] - y[j])/R[i][j];
      ez[i][j] = ez[j][i] = -(z[i] - z[j])/R[i][j];
    }
  }
```
