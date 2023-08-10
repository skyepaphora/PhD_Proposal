# CBC_Simulations.Rmd

\_

### TFS Estimators

The file *CBC_Simulations.Rmd* produces a simulated ensemble of time series, and estimates the time-frequency spectra (TFS) of each series.

**BCTMFSE:** the **B**oundary **C**orrected **M**odified **T**ime **F**requency **S**pectrum **E**stimate

**CBCMTFSE** the *Curvy* version of the BCMTFSE

Both estimates are based on a smoothed version of a multitaper-based TFS estimate, 
called the *Sliding Window High Resolution Spectrogram.*


### What time series are we working with?

These estimates are flexible, aimed at general non-stationary series. For the simulations which produced the plots in the "Plot" folder of this repository, we simulate the UMP, $X(t)$:

$$
\begin{aligned}
    X(t) &= \left( 2 - \exp\left[\frac{-(t-500)^2}{2(200)^2}\right] \right) Y(t)  \\ 
    &\\
    Y(t) &= 0.8 Y(t-1) - 0.4 Y(t-2) + z(t)                                        \\ 
    &\\
    z(t) &= w\big(0, \sigma_z^2 = 10^4\big). 
\end{aligned}
$$

Above, note that $Y$ is a stationary AR(2) process, and $z$ is purely white noise.

---

# C_estimator.Rmd

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
Define the following:

$$
c(1)^2 = a_{1j}*c(j)^2 \qquad a_{1j} = \frac{\textit{rowsum }1}{\textit{rowsum }j}
\qquad 1 < j \leq N
$$

sum both sides over j and divide by N-1

$$
\begin{aligned}
    c(1)^2 &= \frac{\sum_{j=2}^{N}a_{1j} \text{ } c(j)^2}{(N-1)}    \\
           &\quad \vdots \\
    c(N)^2 &= \frac{\sum_{j=2}^{N}a_{Nj} \text{ } c(j)^2}{(N-1)}    \\
\end{aligned}
$$

N unknowns, N equations. Matrix for system of equations:

$$
A_{lj} = \frac{-\textit{rowsum } l}{\textit{rowsum }j} \qquad \textit{(1's on diagonal)} \\
c = \Big[c(1)^2, \dots, c(N)^2\Big]' \\ \text{ } \\
\text{solve: Ac = 0}
$$

---

### Help Skye is confused
I'm sorry sometimes I suck at linear algebra, it's cringe :(

#### Q1 
Why is $Ac$ set equal to zero? I've tried `solve()` (and `qr.solve()`) but all I get back is a zero vector. Which makes sense to me. I get interesting (good) results when I set $Ac = -\vec 1$ where $\vec 1$ is an $N$ length vector of $1$'s. 

Follow up question: why is the numerator of $A_{lj}$ negative? Source: Glen during one of our meetings

---

# Plotter_1.Rmd

This file contains the code for creating all plots in featured in this repository's *Plots* folder. It requires data produced by *CBC_simulations.Rmd* and/or *C_estimates.Rmd,* and also requires the functions and palettes defined in my [*Plot_Animations*](https://github.com/Skyepaphora-Griffith/Plot_Animations.git) repository. 

#### sgram
The Spectrograms are self explanatory, for the most part. If details such as series type (noise, UMP, etc.) or blockwidth (B) aren't labeled on the plot itself, they can be found in the filename.

#### .gif
The animatied GIFs present the horizontal "slices" of a given spectrogram (that is, the frequency-domain slices) in sequence with respect to time.

---















