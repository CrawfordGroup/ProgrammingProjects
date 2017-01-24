If you print the angle between every possible combination of three atoms, you'll get lots of zeroes and angles between atoms that are far apart.   To print mainly interesting angles, use if-else blocks to enforce these restrictions:
```c++
if(i!=j && i!=k && j!=k) { }  /* Skip coincidences */
```

and
```c++
if(i < j && j < k && R[i][j] < 4.0 && R[j][k] < 4.0) { } /* Skip atoms far apart (specifically with bond distances > 4.0 bohr) */
```

Alternatively, you can limit the loop structure and just filter out the bond distances:
```c++
for(int i=0; i < mol.natom; i++) {
  for(int j=0; j < i; j++) {
    for(int k=0; k < j; k++) {
      if(R[i][j] < 4.0 && R[j][k] < 4.0) {
         ...
      }
    }
  }
}
```
