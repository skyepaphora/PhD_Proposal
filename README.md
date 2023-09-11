# pBC_Simulator.Rmd

### TFS Estimators

The file *pBC_Simulator.Rmd* produces a simulated ensemble of time series, and estimates the time-frequency spectra (TFS) of each series.

**BCTMFSE:** the **B**oundary **C**orrected **M**odified **T**ime **F**requency **S**pectrum **E**stimate

**CBCMTFSE** the *Curvy* version of the BCMTFSE

Both estimates are based on a smoothed version of a multitaper-based TFS estimate, 
called the *Sliding Window High Resolution Spectrogram.*


### Default Parameters

These estimates are flexible, aimed at general non-stationary series. For the simulations which produced the plots in this repository, we generally simulate the UMP, $X(t)$:

$$
\begin{aligned}
    X(t) &= c(t)Y(t)  \\ 
    &\\
    c(t) &= \exp\left(\frac{-(t-500)^2}{2(200)^2}\right) 
    &\\
    Y(t) &= 0.5 Y(t-1) - 0.5 Y(t-2) + z(t)                                        \\ 
    &\\
    z(t) &= w\big(0, \sigma_z^2 = 10^4\big). 
\end{aligned}
$$

Above, note that $Y$ is a stationary AR(2) process, and $z$ is white noise.

---

# smooth_estimators.Rmd

### Previous Methods: SVD (Azadeh)

In matrix/vector notation, denote the TFS estimate by $\mathbb S_X = \vec {C^2} \vec S_Y$. 
We now use singular value decomposition:

$$
\hat{\mathbb S}_X = UDV^T \\
\quad \\
\text{Dimensions:}\quad
\begin{cases}
    \hat {\mathbb S}_X &\leftarrow N\times N_f \\
    U &\leftarrow N\times N \\
    D &\leftarrow N\times N_f \\
    V &\leftarrow N_f \times N_f
\end{cases}
$$

In Section 4.2, Azadeh explains that the rank of the estimated LTFS matrix $\ln\hat{\mathbb S}_X$ gives insight into the structure of $X$ as follows:

1. Rank 1 $\implies X$ stationary (Rank 0 for $\mathbb S_X$)
2. Rank 2 $\implies X$ UMP (Rank 1 for $\mathbb S_X$)

Assuming $X(t)$ is UMP, there must only be one non-zero singular value for $\hat {\mathbb S}_X$. So we can simplify:

$$
\hat {\mathbb S}_X \approx U_1 d_1 V_1^T
$$

Where $U_1, V_1$ are the first columns of $U,V$ and $d_1$ is the first singular value of $\hat{\mathbb S}_X$.

Now factor $d_1$ into some pair of nonzero reals $b_u, b_v$. Then

$$
\hat {\mathbb S}_X \approx U_1 d_1 V_1^T = (b_uU_1)(b_vV_1)^T.
$$

There are infinitely many numbers which qualify for $b_u, b_v$, so this is ambiguous... 

We assume $C(t_0) = 1 = C^2(t_0)$ for some $t_0 \in \{0, \dots, N-1\}$. Then $S_X(t_0, f) = S_Y(f) \; \forall f$. ($X$ is now a "normal" UMP). 

Now choose $b_u$ so that $b_uU_1\Big[t_0^{th} \text{ entry}\Big] = 1$. Then $B_v = l_1/b_u$. 

Now your estimates are:

$$
\hat{\vec{C}^2} \stackrel{\small def}{=} b_uU_1 \qquad\qquad \hat{\vec S}_y \stackrel{\small def}{=} b_vV_1^T
$$

### Proposed Method (Skye) [Actually Glen] 
$$
c(i)^2 = a_{ij}c(j)^2 \qquad a_{ij} = \frac{S [rowsum\;i]}{S [rowsum\;j]} = \frac{c(i)^2}{c(j)^2}
\qquad 1 \leq j \leq N
\\ \quad \\
c(i)^2 = a_{ii}c(i)^2 + \sum_{j\neq i} a_{ij}c(j)^2 \\
\therefore 0 = \sum_{j\neq i} a_{ij}c(j)^2
$$


$$
\begin{aligned}
    \sum_{j=1}^N c(i)^2 &= \sum_{j=1}^N a_{ij}c(j)^2 \\  &\\
    c(i)^2 &= \frac{\sum_{j=1}^{N}a_{ij} \, c(j)^2}{N} \qquad i \in \{1,\dots, N\}                        \\ & \\
    c(i)^2 &= \frac{a_{ii}c(i)^2 + \sum_{j\neq i} a_{ij}c(j)^2 }{N} \qquad i \in \{1,\dots, N\}           \\ & \\
    c(i)^2 &= \frac{1}{N}c(i)^2 + \frac{1}{N}\sum_{j\neq i} a_{ij}c(j)^2 \qquad i \in \{1,\dots, N\} \\ & \\
    N(1 - \frac{1}{N}) c(i)^2 &= \sum_{j\neq i} a_{ij}c(j)^2 \qquad i \in \{1,\dots, N\} \\ & \\
    (N - 1) c(i)^2 &= \sum_{j\neq i} a_{ij}c(j)^2 \qquad i \in \{1,\dots, N\} \\&\\
    0 &= N c(i)^2 - c(i)^2 - \sum_{j\neq i} a_{ij}c(j)^2 \\
    0 &= N c(i)^2 - \sum_{j=1}^N a_{ij}c(j)^2
\end{aligned}
$$

N unknowns, N equations. Matrix for system of equations:

$$
A_{ij} = \frac{rowsum\; i}{rowsum\;j} \qquad \text{(1's on diagonal)} \\
c = \Big[c(1)^2, \dots, c(N)^2\Big]' \\ \; \\
\text{solve: }\qquad  \frac{1}{N}Ac = c \\
OR: \quad (1/N)Ac - Ic = 0 \\ 
\quad ((1/N)A - I)c = 0 
$$

JUST FIND eigenvec matching eigenval = 1, for $B = A/N$

---




# Plotter_1.Rmd

This file contains the code for creating all plots in featured in this repository's *Plots* folder. It requires data produced by *CBC_simulations.Rmd* and/or *C_estimates.Rmd,* and also requires the functions and palettes defined in my [*Plot_Animations*](https://github.com/Skyepaphora-Griffith/Plot_Animations.git) repository. 

#### sgram
The Spectrograms are self explanatory, for the most part. If details such as series type (noise, UMP, etc.) or blockwidth (B) aren't labeled on the plot itself, they can be found in the filename.

#### .gif
The animatied GIFs present the horizontal "slices" of a given spectrogram (that is, the frequency-domain slices) in sequence with respect to time.

---















