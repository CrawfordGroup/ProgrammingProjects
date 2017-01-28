Just as for the bond angle code, we need to exclude ijkl combinations involving coincidences among the indices as well as distant atom pairs:
```c++
  if(i!=j && i!=k && i!=l && j!=k && j!=l && k!=l) { } /* Skip coincidences */
```
and
```c++
  if(R[i][k] < 4.0 && R[k][j] < 4.0 && R[k][l] < 4.0) { } /* Skip distant atom pairs */
```
