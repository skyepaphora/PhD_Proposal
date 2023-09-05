# ICASSP Paper Stuff

Go to Overleaf to edit/view the actual paper.

> **General Notes**
>
> All estimates are off by a scale factor, *obviously.* To get around this, I normalized each function (and its estimates) to max out at $1.$ The plots feature a comparison of these normalized estimates, not the originals: the general *shape* of the estimate is what's being compared.
>
> For each method, $\hat g$ is calculated using a single simulation. The plots show the mean result amongst *100 estimates of * $g$. It does **NOT** estimate $g$ based on the mean of the spectrogram results. The same goes for $S_Y(f)$ and its estimates.

---

## CODE

NOTE: all code uses the UMP:  

$$ 
\begin{aligned} 
    X(t) &= c(t)Y(t) \\ 
    &\\
    c(t) &= \exp\left(\frac{-(t-500)^2}{2(200)^2}\right)  \\ 
    &\\
    Y(t) &= 0.5 Y(t-1) - 0.5 Y(t-2) + z(t)                \\ 
    &\\
    z(t) &= w\big(0, \sigma_z^2 = 10^4\big). 
\end{aligned} 
$$

Results computed for block-widths $B = 200, 300$.

---

### Estimating G

#### Produced results using Azadeh's method (singular value decomposition)  
* Have to multiply $\hat g(t)$ by -1
* even then, at some times, $\hat g(t) < 0$. This is illegal, since $g$ is the square of a real-valued function, by definition.

#### Produced results using our method (eigenvector problem)  
* Always positive
* Better on average than SVD method: less bias, also smoother

#### Plotted results

Go to [This Folder](https://github.com/Skyepaphora-Griffith/PhD_Proposal/tree/main/ICASSP/PaperPlots) and look for filenames beginning with `g_`

---

### Estimating $S_Y(f)$

#### Produced results using Azadeh's method (singular value decomposition)  
* Azadeh outlines where this estimate comes from in section 4.3 of her thesis. It's similar to getting $\hat g$, but is based on $V_1$ instead of $U_1$.
* Have to multiply $\hat S_Y(f)$ by -1, like we did for $\hat g(t)$.

#### Produced results using our method (eigenvalue problem)  
* Performs Similarly to SVD method, on average, it seems.

#### Plotted results
Go to [This Folder](https://github.com/Skyepaphora-Griffith/PhD_Proposal/tree/main/ICASSP/PaperPlots) and look for filenames beginning with `yf_`

--- 

### Smooth Spectrograms
* Plotted outer product of $\hat g$ and $\hat S_Y(f)$; estimates taken from our method
* Did this for each simulation, plotted average over all 100 smoothed spectrograms.
* Also plotted results for a single simulation
* Also plotted *un-smoothed* CBC results for comparison.
* **Smoothed Result on average is not as good. BUT, seems to be much better for a single simulation.**

#### Plotted results

Go to [This Folder](https://github.com/Skyepaphora-Griffith/PhD_Proposal/tree/main/ICASSP/PaperPlots) and look for filenames beginning with `sx_`

---

## Paper

#### Standard error
* Talked about this, will consider for proposal, not paper

#### rename estimates
* For polynomials of order $p$, the estimator which uses the NSQI-based boundary correction for the SWHRS will be called the $p$-BC.
* Azadeh's estimates for $g$ and $S_Y(f)$ will be denoted with a subscript $1$. Mine will have a subscript of $2$.

#### Formatting
* smaller plots
* got rid of the $\hat y(t) = x(t)/\hat c(t)$ stuff

---

## What needs to be done

#### references
* The template has two citation types. One for general references, I guess, and one for IEEE proceedings papers? So if I reference *old* IEEE papers I should use the latter? right? 
* Having trouble sourcing an expression for the HRS that matches the one in Azadeh's thesis - equation 3.20
    - checked thomson 93 and 98
    - maybe for now I'll just reference Azadeh idk

#### Formatting
* the titles suck, I know, please help
* why is Wesley's name and info weirdly offset? 
* make equations small enough to fit in a column
* too long - can't fit all figures
* some figures seem to clip off the text in adjacent columns






