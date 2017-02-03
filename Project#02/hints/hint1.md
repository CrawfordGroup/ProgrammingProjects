The Hessian stored in memory should be a square matrix, while the format of the input file is rectangular.  Understanding the translation between the two takes a bit of thinking.  Here's a partial code block that works for this purpose:
```c++
  ...
  FILE *hessian;
  int natom;
  ...
  
  double **H = new double* [natom*3];
  for(int i=0; i < natom*3; i++)
    H[i] = new double[natom*3];
 
  for(int i=0; i < natom*3; i++) {
    for(int j=0; j < natom; j++) {
      fscanf(hessian, "%lf %lf %lf", &H[i][3*j], &H[i][3*j+1], &H[i][3*j+2]);
    }
  }
```
