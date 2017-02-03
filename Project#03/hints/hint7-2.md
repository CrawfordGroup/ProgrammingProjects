The following code illustrates the basic algorithm for building the Fock matrix (F) using the core Hamiltonian matrix (H), the density matrix (D), and the two-electron integrals stored in a one-dimensional array (TEI):
```c++
for(int i=0; i < nao; i++)
  for(int j=0; j < nao; j++) {
    F[i][j] = H[i][j];
    for(int k=0; k < nao; k++)
      for(int l=0; l < nao; l++) {
        ij = INDEX(i,j);
        kl = INDEX(k,l);
        ijkl = INDEX(ij,kl);
        ik = INDEX(i,k);
        jl = INDEX(j,l);
        ikjl = INDEX(ik,jl);
  
        F[i][j] += D[k][l] * (2.0 * TEI[ijkl] - TEI[ikjl]);
     }
  }
```
The `INDEX` function is most easily defined as a macro using the `ioff` array explained in [an earlier hint](./hint3-2.md), e.g.:
```c++
#define INDEX(i,j) (i>j) ? (ioff[i]+j) : (ioff[j]+i)
```
