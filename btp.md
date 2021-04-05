---
title: Project Seminar
author: Shubham Mishra (18CS10066)
---

## Topic


Multiparty Post-Quantum Fully Homomorphic Encryption


## Motivation

<div style="font-size: 1.8rem;">
- Today we want to perform heavy computations in the cloud without assuming confidentiality guarantee on the remote server.
For that we need to use <span style="color: green;">Fully Homomorphic Encryption</span> techniques.


- In addition to that, we also want multiple parties to jointly perform such computations keeping the inputs secret.
This is the classic setup of <span style="color: green;">Secure Multiparty Computation</span>.


- But current systems are slow and have huge ciphertext expansion issues.
It is challenging to create efficient implementations of the same.
</div>


## Problem Definition

- To create an efficient and scalable implementation of Fully Homomorphic Multiparty Computation System using existing established papers.
- To accelerate parts of the system using FPGAs and GPUs.
- If possible, propose improvements upon the existing schemes to reduce noise and ciphertext sizes.


## Reading list

1. [Regev's paper on LWE](https://cims.nyu.edu/~regev/papers/lwesurvey.pdf)
2. [GSW paper](https://eprint.iacr.org/2013/340.pdf)
3. [Mathematics of Lattices by Vindod Vaikuntanathan](https://www.youtube.com/watch?v=LlPXfy6bKIY&feature=youtu.be&ab_channel=SimonsInstitute)
4. [Craig Gentry's PhD Thesis](https://crypto.stanford.edu/craig/craig-thesis.pdf)
5. [FHEW paper](https://eprint.iacr.org/2014/816.pdf)
6. [TFHE paper](https://eprint.iacr.org/2018/421.pdf)
7. [Multiparty Computation in FHE](https://eprint.iacr.org/2015/345.pdf)

## Works done

<div style="font-size: 1.8rem;">
1. Examined the inner workings of the TFHE library.
2. Using Library's internal APIs, demonstrated 2-out-of-2 Threshold Decryption of LWE and TLWE encryption schemes with various bounds of smudging noise.
3. Attempted to propose a MPC Scheme based on Mukherjee-Wilchs' paper with less ciphertext expansion.
But ended up with a partially homomorphic scheme based on GSW which works extra assumption of Public Key Infrastructure.
</div>



## Next plans

- Complete t-out-of-n Threshold Decryption using TFHE.
- Complete noise vs modulus profiling and find out ways to reduce noise and modulus. 
- Port Mukherjee-Wilchs' scheme to TFHE and create an efficient and scalable implementation out of it.
- Help in porting FFT computations to FPGA.

