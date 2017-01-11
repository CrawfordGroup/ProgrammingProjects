It may be convenient to use arrays to store the z-values and Cartesian coordinates of the atoms:
```c++
int zval[50];
double x[50], y[50], z[50]; 
```

A more elegant solution is to allocate the memory dynamically for each array once you know the number of atoms:
```c++
int natom;
input >> natom;

int *zval = new int[natom];
double *x = new double[natom];
double *y = new double[natom];
double *z = new double[natom];

delete[] zval;  delete[] x;  delete[] y;  delete[] z;
```

Don't forget to delete[] the memory after you're finished!
