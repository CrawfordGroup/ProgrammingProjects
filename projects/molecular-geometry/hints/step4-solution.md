We've added a new function to the Molecule class for computing the out-of-plane angles.  Here's the new molecule.h:

```c++
#include <string>

using namespace std;

class Molecule
{
  public:
    int natom;
    int charge;
    int *zvals;
    double **geom;
    string point_group;

    void print_geom();
    void rotate(double phi);
    void translate(double x, double y, double z);
    double bond(int atom1, int atom2);
    double angle(int atom1, int atom2, int atom3);
    double torsion(int atom1, int atom2, int atom3, int atom4);
    double oop(int atom1, int atom2, int atom3, int atom4);
    double unit(int cart, int atom1, int atom2);

    Molecule(const char *filename, int q);
    ~Molecule();
};
```

Here's the new `oop()` function for molecule.cc:

```c++
double Molecule::oop(int a, int b, int c, int d)
{
  double ebcd_x = (unit(1,c,b) * unit(2,c,d) - unit(2,c,b) * unit(1,c,d));
  double ebcd_y = (unit(2,c,b) * unit(0,c,d) - unit(0,c,b) * unit(2,c,d));
  double ebcd_z = (unit(0,c,b) * unit(1,c,d) - unit(1,c,b) * unit(0,c,d));
  
  double exx = ebcd_x * unit(0,c,a);
  double eyy = ebcd_y * unit(1,c,a);
  double ezz = ebcd_z * unit(2,c,a);

  double theta = (exx + eyy + ezz)/sin(angle(b,c,d));

  if(theta < -1.0) theta = asin(-1.0);
  else if(theta > 1.0) theta = asin(1.0);
  else theta = asin(theta);

  return theta;
}
```

And finally the new code that makes use of the class:

```c++
#include "molecule.h"
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

  return 0;
}
```

The above code produces the following output for the acetaldehyde test case:

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
 2- 1- 0 124.268308
 3- 1- 0 115.479341
 3- 2- 1  28.377448
 5- 4- 0  35.109529
 6- 4- 0  35.109529
 6- 5- 0  36.373677
 6- 5- 4  60.484476

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
```
