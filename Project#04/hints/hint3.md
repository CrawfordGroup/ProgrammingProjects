The following code block illustrates a simple-minded MP2 energy calculation with the two-electron integrals stored in a one-dimensional array.  The molecular orbitals are assumed to be ordered with all doubly-occupied orbitals first, followed by the unoccupied/virtual orbitals.  Notice the difference in limits of the loops over *i* and *a*:

```c++
  Emp2 = 0.0;
  for(i=0; i < ndocc; i++) {
    for(a=ndocc; a < nao; a++) {
      ia = INDEX(i,a);
      for(j=0; j < ndocc; j++) {
        ja = INDEX(j,a);
        for(b=ndocc; b < nao; b++) {
          jb = INDEX(j,b);
          ib = INDEX(i,b);
          iajb = INDEX(ia,jb);
          ibja = INDEX(ib,ja);
          Emp2 += TEI[iajb] * (2 * TEI[iajb] - TEI[ibja])/(eps[i] + eps[j] - eps[a] - eps[b]);
        }
      }
    }
  }
```
