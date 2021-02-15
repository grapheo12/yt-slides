---
title: Distributed Decryption of Regev Cryptosystem
author: Shubham Mishra
---

# Regev Cryptosystem

## Introduction

- Introduced by Oded Regev
- This is a public-key cryptosystem based on Learning with Errors


## Notations

- Let $n$ and $m$ be integers
- and let $q$ be a prime (used as the modulus of our field).
- Let $E$ be a discrete random variable defined on $\mathbb{Z}_q$.
This will act as our error function.
- Our message space are bits, i.e., $\lbrace 0, 1 \rbrace$


## Keys

- <span style="color: red;">Private key:</span> An element $\mathbf{s} \in (\mathbb{Z}_q)^n$
- <span style="color: green;">Public key:</span> A set consisting of $m$ samples $(\mathbf{a^i}, b^i)$
where $\mathbf{a^i}$ is drawn uniformly from $(\mathbb{Z}_q)^n$
and $b^i = E + \mathbf{a^i \cdot s}$


## Encryption

- Choose an random subset of the public key, let us call it $S$.
- If the message bit is $0$, ciphertext, $c = \sum_S (\mathbf{a^i}, b^i)$
- If the message bit is $1$, ciphertext, $c = (\sum_S \mathbf{a^i}, \lfloor q/2 \rfloor + \sum_S b^i)$


## Remarks

- Note that all the elements of the public key set, as well as any ciphertext is a valid LWE sample under the secret key $\mathbf{s}$.

- Also, the public key is just a collection of encryption of $0$ message bit.
- This technique is used in other places also to convert symmetric key cryptosystems to public key cryptosystems.
For example, here we converted the vanilla LWE system (which is symmetric key) to Regev's system.


## Decryption

- To decrypt a ciphertext $c = (\mathbf{a}, b)$, compute the quantity $d = b - \mathbf{a \cdot s}$
- If $d$ is closer to $0$, then the message is $0$.
- If $d$ is closer to $\lfloor q/2 \rfloor$, then the message is $1$.



# Distributed Decryption

## Introduction

- Our main goal here is to distribute the private key into multiple parts.
- Such that, even if one part is compromised, the adversary is not able to do decrypt any ciphertext.


## $t$ out of $n$

In a <span style="color: red;">$t$</span>-out-of-<span style="color: green;">$n$</span> setting,
we want to split our secret key among <span style="color: green;">$n$</span> parties,
such that, we shall be able to decrypt iff <span style="color: red;">$\ge t$</span> secret key shares or partial decryptions are present.

## Methods of secret sharing

- Generic $t$-out-of-$n$ secret sharing can be done using **Shamir Secret Sharing**.

- However, here is a simple scheme for $2$-out-of-$2$ sharing:

Let $s$ be the secret key (in some group $(G, +)$).
Let $s_1$ be a random element $\in G$.
Calculate $s_2$ such that $s_1 + s_2 = s$

- $s_1$ and $s_2$ are the two shares.


## Threshold Decryption

- In this setting, no party wants to reveal his share of the secret key.

- Instead, during decryption, each party reveals a partial decryption,
which is a function of the the message they receive after decrypting with their share of the secret key.

- Every party then gathers these partial decryptions and combines them to get the final decrypted message.


## Simple thresholdisation of Regev

- Remember that the main step in decryption is calculating $b - a \cdot s$
- If $s = s_1 + s_2$, $b - a \cdot s = b - a \cdot s_1 - a \cdot s_2$
- So for 2-out-of-2 threshold decryption, the 2 parties will get $s_1$ and $s_2$ as shares.

</section><section>

- At the time of decryption, they will calculate $a \cdot s_i$ and broadcast it.
- After the broadcast, both parties will have $a \cdot s_1$ and $a \cdot s_2$.
- Thus they will be able to decrypt without revealing their shares.


## Problem with this scheme

- Given enough number of $b^j = a^j \cdot s_1$ samples, we have a complete set of equations in the components of $s_1$.

- Thus by solving, holder of $s_2$ will reveal what $s_1$ is.


## Solution

- Do not directly broadcast $a \cdot s_1$.
- Rather add some noise to it, ie, broadcast $a \cdot s_1 + e$ where $e$ is a small noise.

</section><section>

- <span style="color: red;">Why does it still work?:</span> Because the decryption scheme in Regev is itself noisy and not deterministic. So an addition of error bounded by a small number, should not cause any problem with decryption.

- <span style="color: green;">Why is it more secure:</span> By adding the noise, we are essentially creating LWE sample with secret key $s_1$. So, by the security guarantee given by LWE problem, it is impossible to reveal $s_1$ in polytime.

