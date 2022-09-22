A cross product between two vectors is another vector. Therefore, to store the cross product needed to compute a given out-of-plane angle, you need to store the x, y, and z components of the resulting vector, which you then use to compute a dot product with yet another vector. It is convenient to assign separate variables for each part of this calculation:
```c++
ejkl_x = (ey[k][j] * ez[k][l] - ez[k][j] * ey[k][l]);
ejkl_y = (ez[k][j] * ex[k][l] - ex[k][j] * ez[k][l]);
ejkl_z = (ex[k][j] * ey[k][l] - ey[k][j] * ex[k][l]);
 
exx = ejkl_x * ex[k][i];
eyy = ejkl_y * ey[k][i];
ezz = ejkl_z * ez[k][i];
```
