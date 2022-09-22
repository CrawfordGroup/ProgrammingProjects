If we choose to store the matrix of bond distances, we need to allocate the necessary memory, either as a static two-dimensional array:
```c++
double R[50][50];
```

or via dynamic allocation using the [Molecule class](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Classes-and-Objects):
```c++
double **R = new double* [mol.natom];
for(int i=0; i < mol.natom; i++)
  R[i] = new double[mol.natom];
```

Don't forget to delete[] the memory at the end of the program:
```c++
for(int i=0; i < mol.natom; i++)
  delete[] R[i];
delete[] R;
```
