# Project #4: The second-order Moller-Plesset perturbation (MP2) energy
Unlike the Hartree-Fock energy, correlation energies like the MP2 energy are usually expressed in terms of MO-basis quantities (integrals, MO energies). 
The most expensive part of the calculation is the transformation of the two-electron integrals from the AO to the MO basis representation.  
The purpose of this project is to understand this transformation and fundamental techniques for its efficient implementation. 
The theoretical background and a concise set of instructions for this project may be found [[http://sirius.chem.vt.edu/~crawdad/programming/mp2.pdf|here]].

## Step #1: Read the Two-Electron Integrals
The Mulliken-ordered integrals are defined as:

```
EQUATION
(\mu \nu|\lambda \sigma) \equiv \int \phi_\mu({\mathbf r_1})
\phi_\nu({\mathbf r_1}) r_{12}^{-1} \phi_\lambda({\mathbf r_2})
\phi_\sigma({\mathbf r_2}) d{\mathbf r_1} d{\mathbf r_2}
```

Concise instructions for this step can be found in 
[Project #3](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2303)

## Step #2: Obtain the MO Coefficients and MO Energies 
Use the values you computed in the Hartree-Fock program of 
[Project #3](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2303)
## Step #3: Transform the Two-Electron Integrals to the MO Basis 
### The Noddy Algorithm 

The most straightforward expression of the AO/MO integral transformation is

```
EQUATION
(pq|rs) = \sum_\mu \sum_\nu \sum_\lambda \sum_\sigma C_\mu^p C_\nu^q
(\mu \nu|\lambda \sigma) C_\lambda^r C_\sigma^s
```

This approach is easy to implement (hence the word "[noddy](http://www.hackerslang.com/noddy.html)" above), but is expensive due to its N<sup>8</sup> computational order.  
Nevertheless, you should start with this algorithm to get your code working, and run timings (use the UNIX "time" command) 
for the test cases below to get an idea of its computational cost.

  * Hint 1: Noddy transformation code
### The Smarter Algorithm

Notice that none of the *C* coefficients in the above expression have any indices in common.  Thus, the summation could be rearranged such that:
```
EQUATION 
(pq|rs) = \sum_\mu C_\mu^p \left[ \sum_\nu C_\nu^q \left[ \sum_\lambda  C_\lambda^r \left[ \sum_\sigma C_\sigma^s (\mu \nu|\lambda \sigma) \right] \right] \right].
```

This means that each summation within brackets could be carried out separately, 
starting from the innermost summation over <html>&#963;</html>, if we store the results at each step.  
This reduces the N<sup>8</sup> algorithm above to four N<sup>5</sup> steps.

Be careful about the permutational symmetry of the integrals and intermediates at each step: 
while the AO-basis integrals have eight-fold permutational symmetry, the partially transformed integrals have much less symmetry.

After you have the noddy algorithm working and timed, modify it to use this smarter algorithm and time the test cases again.  Enjoy!

  * Hint 2: Smarter transformation code

## Step #4: Compute the MP2 Energy

```
EQUATION
E_{\rm MP2} = \sum_{ij} \sum_{ab} \frac{(ia|jb) \left[ 2 (ia|jb) -
(ib|ja) \right]}{\epsilon_i + \epsilon_j - \epsilon_a - \epsilon_b},
```

where *i* and *j* denote doubly-occupied orbitals and *a* and *b* unoccupied orbitals, and the denominator involves the MO energies.

  * Hint 3: Occupied versus unoccupied orbitals

## Test Cases
The input structures, integrals, etc. for these examples are found in the [input directory](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2304/input).

* STO-3G Water | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2304/output/h2o/STO-3G/output.txt)
* DZ Water | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2304/output/h2o/DZ/output.txt)
* DZP Water | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2304/output/h2o/DZP/output.txt)
* STO-3G Methane | [output](https://github.com/CrawfordGroup/ProgrammingProjects/blob/master/Project%2304/output/ch4/STO-3G/output.txt)

