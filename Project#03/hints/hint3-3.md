Previously the [Hessian](../../Project%2302/hints/hint1.md) ([Project #2](../../Project%2302/)) and the one-electron quantities so far in [Project 3](../../Project%2303) have been provided in an order that makes reading them in using a loop structure trivial. 

```c++
  ...
  
  FILE *input;
  int a, b;
  double **S;
  
  ...
  
  input = fopen("s.dat", "r");
  for(int i=0; i < nao; i++) {
    for(int j=0; j <= i; j++) {
      fscanf(hessian, "%d %d %lf", &a, &b, &S[i][j]);
      S[j][i] = S[i][j];
    }
  }
  fclose(input);
```

However the two-electron integrals are not provided in this convenient ordering, you could go through the file and attempt to reorder them so that a loop structure works, or you could put the previously ignored index information you're reading with your fscanf to good use. This prevents the use of hard-wired loops that assume a specific ordering of the data, and it also prevents having to calculate how many elements are in the file to be read.

```c++
  ...
  
  FILE *input;
  int i, j, k, l;
  double val;
  double **TEI;
  
  ...
  
  input = fopen("eri.dat", "r");
  while(fscanf(input, "%d %d %d %d %lf", &i, &j, &k, &l, &val) != EOF) {
  
  ...
  
    TEI[ijkl] = val;
  }
  fclose(input);
```
The `EOF` above is the [end-of-file](http://en.wikipedia.org/wiki/End-of-file) condition, so `!= EOF` means the above while loop scans the file until it reaches the end.
