# C++ Programming Tutorial in Chemistry
This tutorial is intended to touch on many, but certainly not all, of the fundamentals of C++ programming with an emphasis on quantum chemistry.  Although I hope this section will get you started, it is not a substitute for a more complete reference manual.  For more C++ language details, you may find the standard text by Josuttis [buy it](http://www.amazon.com/C-Standard-Library-Tutorial-Reference/dp/0201379260) useful or, for VT users, get it [on-line from the campus library](http://proquest.safaribooksonline.com/0201379260) or a decent on-line tutorial such as [this one](http://www.cplusplus.com/doc/tutorial/) or [this one](http://www.cprogramming.com/tutorial.html). 

If you are new to programming, one way to approach this tutorial is to read through "The Fundamentals" list on the [wiki](https://github.com/CrawfordGroup/ProgrammingProjects/wiki) first, then proceed with Project #1, using the earlier material as a reference. If you are already experienced with programming, you may be able to start immediately with Project #1. If you already have experience with electronic structure theory programs, then you may be ready for the Hartee-Fock programming project or even more advanced topics. 

# Getting Started
This repository is organized into several projects, each with its own directory.
In each one you will find a `README.md` file like this one with instructions,
and output for you to check your implementation against.
These projects will also require some input files that will be discussed 
in each project as they become relevant. 
These input files can be found in the `inputs` directory. 
Within `input` there are directories for several different molecule/basis-set
combinations where you will find integrals, molecular geometries and other files to use as input to your programs.

The wiki for this repository has some discussion of useful topics. 
Reading over the topics in the [wiki](addlink) is a good way to familiarize yourself with concepts you will use to complete these projects.
The Fundamentals list below has links to pages within the wiki.

To begin work on the projects you can create a `clone` of this repository. 
First navigate to the directory where you would like to keep your programming projects. Then create the clone by this command
```shell
git clone git@github.com:CrawfordGroup/ProgrammingProjects.git
```
Now you should see a directory called `ProgrammingProjects` inside you will find all of the files that you can see on github.

# The Fundamentals 
 - [An Initial Example](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/An-Initial-Example)
 - [What is a "Compilation"](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/What-is-a-%22Compilation%22%3F) 
 - [Code Comments](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Code-Comments)
 - [Data Types and Variables](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Data-Types-and-Variables)
 - [Operators](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Operators)
 - [Control Statements](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Control-Statements)
 - [Input/Output](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Input-Output)
 - [Functions](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Functions)
 - [Variable Scope and Reference Types](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Variable-Scope-and-Reference-Types)
 - [Memory Allocation](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Memory-Allocation)
 - [Classes and Objects](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Classes-and-Objects)
 - [Overloading and Templates](https://github.com/CrawfordGroup/ProgrammingProjects/wiki/Overloading-and-Templates)

# Quantum Chemistry Programming Projects 
 - [Project #1](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2301): Molecular Geometry/rotational constant analysis
 - [Project #2](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2302): Harmonic Vibrational analysis
 - [Project #3](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2303): The Hartree-Fock self-consistent field (SCF) procedure.
 - [Project #4](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2304): The second-order Moller-Plesset perturbation (MP2) energy.
 - [Project #5](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2305): The coupled cluster singles and doubles (CCSD) energy.
 - [Project #6](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2306): A perturbative triples correction to CCSD [CCSD(T)].
 - [Project #7](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2307): Connecting your code to PSI4.
 - [Project #8](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2308): DIIS extrapolation for the SCF procedure.
 - [Project #9](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2309): Using symmetry in the SCF procedure.
 - [Project #10](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2310): DIIS extrapolation for solving the CC amplitude equations.
 - [Project #11](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2311): An "out of core" SCF procedure.
 - [Project #12](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2312): Excited Electronic States: CIS and TDHF/RPA
 - [Project #13](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2313): the Davidson-Liu Algorithm: CIS
 - [Project #14](https://github.com/CrawfordGroup/ProgrammingProjects/tree/master/Project%2314): Excited Electronic States: EOM-CCSD (*In Preparation*)
 
# Possible Future Projects
 - Some Future Projects
 - SCF Analytic Energy Gradients
 - MP2 Analytic Energy Gradients
 - Integral-direct SCF
 - Response properties: Hartree-Fock dipole-polarizabilities
 - Response properties: CCSD dipole-polarizabilities
 - Local MP2
