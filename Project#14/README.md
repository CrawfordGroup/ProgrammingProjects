# Project #14: Excited Electronic States: EOM-CCSD

Description of EOM-CCSD
An overview of the equation of motion coupled-cluster method is given in <sup id="r1">[1](#f1)</sup>.

## Step 1: Obtain CCSD T-amplitudes

You require the converged T-amplitudes generated in [Project # 5](../Project%2305). You should also import the one- and two-electron components of the Hamiltonian.

## Step 2: Create matrix elements of the similarity-transformed Hamiltonian

The similarity-transformed Hamiltonian may be written as:

<img src="./figures/so_sim_trans_H.png" height="60">

in terms of sums over one-body, two-body and higher terms. These terms can then be found via the BCH expansion of the similarity-transformed Hamiltonian, in terms of converged T-amplitudes and one- and two-electron components of the Hamiltonian.

## Step 3: Diagonalize the similarity-transformed Hamiltonian

## Bonus step: Left hand eigenvectors and oscillator strengths

### References
<b id="f1">1</b>: Stanton, J. F.; Bartlett, R. J. "The Equation of Motion Coupled-Cluster Method. A Systematic Biorthogonal Approach to Molecular Excitation Energies, Transition Probabilities, and Excited State Properties." *J. Chem. Phys.* **10** , 981 (1993). [(return to text)](#r1)

<b id="f2">2</b>: Zuev, D.; Vecharynski, E.; Yang, C.; Orms, N.; Krylov, A. I. "New Algorithms for Iterative Matrix-Free Eigensolvers in Quantum Chemistry." *J. Comput. Chem.* **36 (5)**, 273–284 (2015). [(return to text)](#r2)
