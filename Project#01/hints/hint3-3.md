If you choose to store the bond angles for later use (not absolutely necessary, as we'll see), you need a three-dimensional array:
```c++
  double ***phi = new double** [mol.natom];
  for(int i=0; i < mol.natom; i++) {
    phi[i] = new double* [mol.natom];
    for(int j=0; j < mol.natom; j++) {
      phi[i][j] = new double[mol.natom];
    }
  }
```
