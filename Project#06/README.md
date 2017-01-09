# Project #6: A perturbative triples correction to CCSD: CCSD(T)

The CCSD(T) method is often referred to as the "gold standard" of quantum chemistry for its high accuracy and reliability.  The purpose of this project is to illustrate the fundamental aspects of an efficient implementation of the (T) energy correction.  This project builds upon the results of 
[Project #5](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2305).

The spin-orbital expression for the (T) correction, using the same notation as in 
[Project #5](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2305), is:

```
EQUATION
E_{\rm (T)} = \frac{1}{36} \sum_{ijkabc} t_{ijk}^{abc}(c) D_{ijk}^{abc} \left[ t_{ijk}^{abc}(c) + t_{ijk}^{abc}(d) \right],
```


where 

```
EQUATION
D_{ijk}^{abc} = f_{ii} + f_{jj} + f_{kk} - f_{aa} - f_{bb} - f_{cc},
```


the "disconnected" triples are defined as

```
EQUATION
D_{ijk}^{abc} t_{ijk}^{abc}(d) = P(i/jk) P(a/bc) t_i^a \langle jk || bc \rangle,
```


and the "connected" triples as

```
EQUATION
D_{ijk}^{abc} t_{ijk}^{abc}(c) = P(i/jk) P(a/bc) \left[ \sum_e t_{jk}^{ae} \langle ei||bc \rangle - \sum_m t_{im}^{bc} \langle ma||jk \rangle \right].
```


The three-index permutation operator is defined by its action on an algebraic function as

```
EQUATION
P(p/qr) f(pqr) = f(pqr) - f(qpr) - f(rqp).
```


The total energy is

```
EQUATION
E_{\rm total} = E_{\rm SCF} + E_{\rm CCSD} + E_{\rm (T)}.
```


## Algorithm #1: Full Storage of Triples

The most straightforward approach to evaluation of the (T) energy correction is to compute and store explicitly the connected and disconnected triples and plug them into the energy expression above. Store the triples amplitudes as six-dimensional arrays over occupied and virtual spin orbitals. 
## Algorithm #2: Avoided Storage of Triples

Note that each T<sub>3</sub> amplitude depends on all the T<sub>1</sub> and T<sub>2</sub> amplitudes, **not** on other triples.  This suggests that the calculation of the T<sub>3</sub> amplitudes appearing in the energy expression could proceed one amplitude at a time:

```
  Loop over i
    Loop over j
      Loop over k
        Loop over a
          Loop over b
            Loop over c
  
            Compute connected and disconnected T3 amplitudes for current i,j,k,a,b,c combination
  
            Calculate contribution of these T3 amplitudes to the (T) energy
  
            End c loop
          End b loop
        End a loop
      End k loop
    End j loop
  End i loop
```

This algorithm reduces the storage (memory and disk) requirements of the (T) correction **considerably**.  One can conceive of other approaches as well, including calculations of batches of T<sub>3</sub> amplitudes (rather than one at a time) to improve floating-point performance.  For example:

```
  Loop over i
    Loop over j
      Loop over k
  
        Compute all T3 amplitudes (all a,b,c combinations) for current i,j,k
  
        Calculation contribution of these T3 amplitudes to the (T) energy
  
      End k loop
    End j loop
  End i loop
```

This approach requires more storage (on the order v<sup>3</sup>) than the one-at-a-time approach, but can be considerably faster of modern high-performance computers.  A good discussion of the most efficient algorithm can be found in A. P. Rendell, T. J. Lee, A. Komornicki, //Chem. Phys. Lett.// **178**, 462-470 (1991).

## Test Cases
The input structures, integrals, etc. for these examples may be found in the [input](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2306/input) 
directory, the CCSD Energies can be found in [Project #5](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2305).

* STO-3G Water | [Output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2306/output/h2o/STO-3G/output.txt) 
* DZ Water | [Output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2306/output/h2o/DZ/output.txt) 
* DZP Water | [Output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2306/output/h2o/DZP/output.txt) 
* STO-3G Methane | [Output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2306/output/ch4/STO-3G/output.txt) 
