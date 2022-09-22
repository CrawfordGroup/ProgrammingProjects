Note that this is only the code for the `main()` function.  The Eigen package, which provides the Matrix class and associated diagonalization capabilities is described in a [hint](./hint7-1.md).

```c++
#include "molecule.h"
#include "masses.h"
 
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdio>
#include <cmath>
 
#include "Eigen/Dense"
#include "Eigen/Eigenvalues"
#include "Eigen/Core"
 
typedef Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor> Matrix;
typedef Eigen::Matrix<double, Eigen::Dynamic, 1> Vector;
 
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
  for(int i=0; i < natom; i++) M += an2masses[(int) mol.zvals[i]];
 
  double xcm=0.0;
  double ycm=0.0;
  double zcm=0.0;
  double mi;
  for(int i=0; i < natom; i++) {
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
 
  Matrix I(3,3);
 
  for(int i=0; i < mol.natom; i++) {
    mi = masses[(int) mol.zvals[i]];
    I(0,0) += mi * (mol.geom[i][1]*mol.geom[i][1] + mol.geom[i][2]*mol.geom[i][2]);
    I(1,1) += mi * (mol.geom[i][0]*mol.geom[i][0] + mol.geom[i][2]*mol.geom[i][2]);
    I(2,2) += mi * (mol.geom[i][0]*mol.geom[i][0] + mol.geom[i][1]*mol.geom[i][1]);
    I(0,1) -= mi * mol.geom[i][0]*mol.geom[i][1];
    I(0,2) -= mi * mol.geom[i][0]*mol.geom[i][2];
    I(1,2) -= mi * mol.geom[i][1]*mol.geom[i][2];
  }
 
  I(1,0) = I(0,1);
  I(2,0) = I(0,2);
  I(2,1) = I(1,2);
 
  cout << "\nMoment of inertia tensor (amu bohr^2):\n";
  cout << I << endl;
 
  // find the principal moments
  Eigen::SelfAdjointEigenSolver<Matrix> solver(I);
  Matrix evecs = solver.eigenvectors();
  Matrix evals = solver.eigenvalues();
 
  cout << "\nPrincipal moments of inertia (amu * bohr^2):\n";
  cout << evals << endl;
 
  double conv = 0.529177249 * 0.529177249;
  cout << "\nPrincipal moments of inertia (amu * AA^2):\n";
  cout << evals * conv << endl;
 
  conv = 1.6605402E-24 * 0.529177249E-8 * 0.529177249E-8;
  cout << "\nPrincipal moments of inertia (g * cm^2):\n";
  cout << evals * conv << endl;
 
  // classify the rotor 
  if(mol.natom == 2) cout << "\nMolecule is diatomic.\n";
  else if(evals(0) < 1e-4) cout << "\nMolecule is linear.\n";
  else if((fabs(evals(0) - evals(1)) < 1e-4) && (fabs(evals(1) - evals(2)) < 1e-4))
    cout << "\nMolecule is a spherical top.\n";
  else if((fabs(evals(0) - evals(1)) < 1e-4) && (fabs(evals(1) - evals(2)) > 1e-4))
    cout << "\nMolecule is an oblate symmetric top.\n";
  else if((fabs(evals(0) - evals(1)) > 1e-4) && (fabs(evals(1) - evals(2)) < 1e-4))
    cout << "\nMolecule is a prolate symmetric top.\n";
  else cout << "\nMolecule is an asymmetric top.\n";
 
  // compute the rotational constants 
  double _pi = acos(-1.0);
  conv = 6.6260755E-34/(8.0 * _pi * _pi);
  conv /= 1.6605402E-27 * 0.529177249E-10 * 0.529177249E-10;
  conv *= 1e-6;
  cout << "\nRotational constants (MHz):\n";
  cout << "\tA = " << conv/evals(0) << "\t B = " << conv/evals(1) << "\t C = " << conv/evals(2) << endl;
 
  conv = 6.6260755E-34/(8.0 * _pi * _pi);
  conv /= 1.6605402E-27 * 0.529177249E-10 * 0.529177249E-10;
  conv /= 2.99792458E10;
  cout << "\nRotational constants (cm-1):\n";
  cout << "\tA = " << conv/evals(0) << "\t B = " << conv/evals(1) << "\t C = " << conv/evals(2) << endl;
 
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

Moment of inertia tensor (amu bohr^2):
    156.154091561645       0.000000000000     -52.855584120568
      0.000000000000     199.371126996236       0.000000000000
    -52.855584120568       0.000000000000      54.459548882464

Principal moments of inertia (amu * bohr^2):
      31.964078  178.649562  199.371127

Principal moments of inertia (amu * AA^2):
       8.950855   50.026980   55.829610

Principal moments of inertia (g * cm^2):
    1.486325e-39 8.307181e-39 9.270731e-39

Molecule is an asymmetric top.

Rotational constants (MHz):
    A = 56461.542    B = 10102.130   C =  9052.169

Rotational constants (cm-1):
    A = 1.8834   B = 0.3370  C = 0.3019
```
