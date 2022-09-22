# Project #10: DIIS extrapolation for solving the CC amplitude equations
In an earlier project, we examined how DIIS ("direct inversion in the iterative
subspace") can reduce substantially the number of iterations required to converge the
self-consistent field.  In this project, we examine how DIIS can similarly speed
convergence in the CC amplitude equations.  This approach was first used by Scuseria,
Lee, and Schaefer in 1986 ["Accelerating the conference of the coupled-cluster
approach.  The use of the DIIS method", *Chem. Phys. Lett.* **130**, 236 (1986)].

## Error Vectors
The DIIS approach requires a well-defined "error vector", a quantity that approaches
zero as the equations converge.  In the SCF procedure, we use the atomic-orbital
representation of the occupied-virtual block of the Fock matrix. In the CC method, we
could choose the difference between successive sets of cluster amplitudes:

<img src="./figures/error-vector.png" height="20">

where <b>T</b><sub>i</sub> represents a vector containing all the cluster amplitudes for the *i*-th iteration.

There are three important points to note about this choice of error vector:
  * Defining the error vectors as differences between successive sets of amplitudes
    implies that one cannot begin the DIIS extrapolation until at least three
    iterations are complete.
  * Just as in the SCF DIIS procedure, error vectors should only be computed using
    <b><i>non-extrapolated</i></b> sets of cluster amplitudes.
  * The set of cluster amplitudes can require substantial memory for larger
    molecules; hence, the choice of the number of error vectors used in the CC DIIS
    procedure is potentially dependent on the available storage (disk and memory).

## Extrapolation
Given the above definition of the error vectors, the set of linear equations to be solved is the same as that for the SCF DIIS procedure:

<img src="./figures/sys-lin-eqn-ci.png" height="125">

where &lambda; is a Lagrangian multiplier and the elements <i>B<sub>ij</sub></i> are computed as dot products of error matrices:

<img src="./figures/Bij.png" height="20">

A new set of cluster amplitudes is then obtained as a linear combinations of older amplitudes using the coefficients from the linear equations above:

<img src="./figures/new-t-amps.png" height="50">

Again: The extrapolated cluster amplitudes should be used only in the CC amplitude equations, not to compute subsequent error vectors.

## Results
Once the procedure is working, you should observe a considerable reduction in the
number of iterations required to converge the CC amplitude equations to a given
tolerance.  For example, without DIIS extrapolation, the STO-3G H<sub>2</sub>O test
case from [Project #5](../Project%2305) converges in 38 iterations to a
precision of 10<sup>-12</sup>:

```
iter =  1  Ecc =      -0.062758205955
iter =  2  Ecc =      -0.067396582597
iter =  3  Ecc =      -0.069224536410
iter =  4  Ecc =      -0.070007757556
iter =  5  Ecc =      -0.070360041902
iter =  6  Ecc =      -0.070523820218
iter =  7  Ecc =      -0.070602032617
iter =  8  Ecc =      -0.070640293027
iter =  9  Ecc =      -0.070659428829
iter = 10  Ecc =      -0.070669194426
iter = 11  Ecc =      -0.070674268048
iter = 12  Ecc =      -0.070676944995
iter = 13  Ecc =      -0.070678375859
iter = 14  Ecc =      -0.070679148887
iter = 15  Ecc =      -0.070679570139
iter = 16  Ecc =      -0.070679801279
iter = 17  Ecc =      -0.070679928796
iter = 18  Ecc =      -0.070679999445
iter = 19  Ecc =      -0.070680038717
iter = 20  Ecc =      -0.070680060604
iter = 21  Ecc =      -0.070680072825
iter = 22  Ecc =      -0.070680079661
iter = 23  Ecc =      -0.070680083488
iter = 24  Ecc =      -0.070680085633
iter = 25  Ecc =      -0.070680086836
iter = 26  Ecc =      -0.070680087511
iter = 27  Ecc =      -0.070680087891
iter = 28  Ecc =      -0.070680088103
iter = 29  Ecc =      -0.070680088223
iter = 30  Ecc =      -0.070680088290
iter = 31  Ecc =      -0.070680088328
iter = 32  Ecc =      -0.070680088349
iter = 33  Ecc =      -0.070680088361
iter = 34  Ecc =      -0.070680088368
iter = 35  Ecc =      -0.070680088372
iter = 36  Ecc =      -0.070680088374
iter = 37  Ecc =      -0.070680088375
iter = 38  Ecc =      -0.070680088376
```

The DIIS extrapolation with eight error vectors reduces the number of iterations to just 16:

```
iter =  1  Ecc =      -0.062758205955
iter =  2  Ecc =      -0.067396582597
iter =  3  Ecc =      -0.070325967097
iter =  4  Ecc =      -0.070642541851
iter =  5  Ecc =      -0.070681441999
iter =  6  Ecc =      -0.070679216733
iter =  7  Ecc =      -0.070680252965
iter =  8  Ecc =      -0.070680084062
iter =  9  Ecc =      -0.070680084577
iter = 10  Ecc =      -0.070680089084
iter = 11  Ecc =      -0.070680088015
iter = 12  Ecc =      -0.070680088239
iter = 13  Ecc =      -0.070680088359
iter = 14  Ecc =      -0.070680088381
iter = 15  Ecc =      -0.070680088377
iter = 16  Ecc =      -0.070680088376
```


## Additional Reading
  * G.E. Scuseria, T.J. Lee, and H.F. Schaefer, "Accelerating the conference of the
    coupled-cluster approach.  The use of the DIIS method", *Chem. Phys. Lett.*
    **130**, 236 (1986).
  * G.D. Purvis and R.J. Bartlett, "The reduced linear equation method in coupled
    cluster theory", *J. Chem. Phys.* **75**, 1284 (1981).
