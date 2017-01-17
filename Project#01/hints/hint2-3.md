To print the interatomic distance matrix, we could just run through its unique values:
```c++
  for(int i=0; i < mol.natom; i++)
    for(int j=0; j < i; j++)
      printf("%d %d %8.5f\n", i, j, R[i][j]);
```
Note the conditional on the index `j` which keeps the code form printing redundant information.
