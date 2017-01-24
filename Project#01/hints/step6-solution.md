Note that the header file, `masses.h` is not provided.  See the [Hint](./hint6-2.md) to learn how to construct it.  Also note that we've made convenient use of our `translate()` member function for the Molecule class.

```c++
#include "molecule.h"
#include "masses.h"

#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <cmath>

using namespace std;

int main()
{
  Molecule mol("geom.dat", 0);

  cout << "Number of atoms: " << mol.natom << endl;
  cout << "Input Cartesian coordinates:\n";
  mol.print_geom();

  cout << "Interatomic distances (bohr):\n";
  for(int i=0; i < mol.natom; i++)
    for(int j=0; j < i; j++)
      printf("%d %d %8.5f\n", i, j, mol.bond(i,j));

  cout << "\nBond angles:\n";
  for(int i=0; i < mol.natom; i++) {
    for(int j=0; j < i; j++) {
      for(int k=0; k < j; k++) {
        if(mol.bond(i,j) < 4.0 && mol.bond(j,k) < 4.0)
          printf("%2d-%2d-%2d %10.6f\n", i, j, k, mol.angle(i,j,k)*(180.0/acos(-1.0)));
      }
    }
  }

  cout << "\nOut-of-Plane angles:\n";
  for(int i=0; i < mol.natom; i++) {
    for(int k=0; k < mol.natom; k++) {
      for(int j=0; j < mol.natom; j++) {
        for(int l=0; l < j; l++) {
          if(i!=j && i!=k && i!=l && j!=k && k!=l && mol.bond(i,k) < 4.0 && mol.bond(k,j) < 4.0 && mol.bond(k,l) < 4.0)
              printf("%2d-%2d-%2d-%2d %10.6f\n", i, j, k, l, mol.oop(i,j,k,l)*(180.0/acos(-1.0)));
        }
      }
    }
  }

  cout << "\nTorsional angles:\n\n";
  for(int i=0; i < mol.natom; i++) {
    for(int j=0; j < i; j++) {
      for(int k=0; k < j; k++) {
        for(int l=0; l < k; l++) {
          if(mol.bond(i,j) < 4.0 && mol.bond(j,k) < 4.0 && mol.bond(k,l) < 4.0)
            printf("%2d-%2d-%2d-%2d %10.6f\n", i, j, k, l, mol.torsion(i,j,k,l)*(180.0/acos(-1.0)));
        }
      }
    }
  }
  
  /* find the center of mass (COM) */
  double M = 0.0;
  for(int i=0; i < mol.atom; i++) M += an2masses[(int) mol.zvals[i]];

  double xcm=0.0;
  double ycm=0.0;
  double zcm=0.0;
  double mi;
  for(int i=0; i < mol.atom; i++) {
    mi = an2masses[(int) mol.zvals[i]];
    xcm += mi * mol.geom[i][0];
    ycm += mi * mol.geom[i][1];
    zcm += mi * mol.geom[i][2];
  }
  xcm /= M;
  ycm /= M;
  zcm /= M;
  printf("\nMolecular center of mass: %12.8f %12.8f %12.8f\n", xcm, ycm, zcm);

  mol.translate(-xcm, -ycm, -zcm);

  return 0;
}
```

The above code produces the following output when applied to the acetaldehyde test case:

```
Number of atoms: 7
Input Cartesian coordinates:
6       0.000000000000       0.000000000000       0.000000000000
6       0.000000000000       0.000000000000       2.845112131228
8       1.899115961744       0.000000000000       4.139062527233
1      -1.894048308506       0.000000000000       3.747688672216
1       1.942500819960       0.000000000000      -0.701145981971
1      -1.007295466862      -1.669971842687      -0.705916966833
1      -1.007295466862       1.669971842687      -0.705916966833
Interatomic distances (bohr):
1 0  2.84511
2 0  4.55395
2 1  2.29803
3 0  4.19912
3 1  2.09811
3 2  3.81330
4 0  2.06517
4 1  4.04342
4 2  4.84040
4 3  5.87463
5 0  2.07407
5 1  4.05133
5 2  5.89151
5 3  4.83836
5 4  3.38971
6 0  2.07407
6 1  4.05133
6 2  5.89151
6 3  4.83836
6 4  3.38971
6 5  3.33994

Bond angles:
 0- 1- 2 124.268308
 0- 1- 3 115.479341
 0- 4- 5  35.109529
 0- 4- 6  35.109529
 0- 5- 6  36.373677
 1- 2- 3  28.377448
 4- 5- 6  60.484476

Out-of-plane angles:
 0- 3- 1- 2  -0.000000
 0- 6- 4- 5  19.939726
 0- 6- 5- 4 -19.850523
 0- 5- 6- 4  19.850523
 1- 5- 0- 4  53.678778
 1- 6- 0- 4 -53.678778
 1- 6- 0- 5  54.977064
 2- 3- 1- 0   0.000000
 3- 2- 1- 0  -0.000000
 4- 5- 0- 1 -53.651534
 4- 6- 0- 1  53.651534
 4- 6- 0- 5 -54.869992
 4- 6- 5- 0  29.885677
 4- 5- 6- 0 -29.885677
 5- 4- 0- 1  53.626323
 5- 6- 0- 1 -56.277112
 5- 6- 0- 4  56.194621
 5- 6- 4- 0 -30.558964
 5- 4- 6- 0  31.064344
 6- 4- 0- 1 -53.626323
 6- 5- 0- 1  56.277112
 6- 5- 0- 4 -56.194621
 6- 5- 4- 0  30.558964
 6- 4- 5- 0 -31.064344

Torsional angles:

 3- 2- 1- 0 180.000000
 6- 5- 4- 0  36.366799

Molecular center of mass:   0.64494926   0.00000000   2.31663792
```
