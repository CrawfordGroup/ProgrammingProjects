Each unit vector points from one atom to another, hence each Cartesian component should be treated as a matrix, much like the interatomic distance matrix.  For now, let's store the unit vectors in memory, but later we'll write a function to recompute them as needed:
```c++
  double **ex = new double* [mol.natom];
  double **ey = new double* [mol.natom];
  double **ez = new double* [mol.natom];
  for(int i=0; i < mol.natom; i++) {
    ex[i] = new double[mol.natom];
    ey[i] = new double[mol.natom];
    ez[i] = new double[mol.natom];
  }
```
And don't forget to delete[] them at the end:
```c++
  for(int i=0; i < mol.natom; i++) {
    delete[] ex[i]; delete[] ey[i]; delete[] ez[i];
  }
  delete[] ex; delete[] ey; delete[] ez;
```
