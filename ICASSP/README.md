# ICASSP Paper Stuff

Go to Overleaf to edit/view the actual paper.

> **General Notes**
>
> All estimates are off by a scale factor, *obviously.* To get around this, I normalized each function (and its estimates) to max out at $1.$ The plots feature a comparison of these normalized estimates, not the originals: the general *shape* of the estimate is what's being compared.
>
> For each method, $\hat g$ is calculated using a single simulation. The plots show the mean result amongst *100 estimates of * $g$. It does **NOT** estimate $g$ based on the mean of the spectrogram results. The same goes for $S_Y(f)$ and its estimates.

---

## CODE

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

#### Produced results using our method (eigenvector problem)  

* Performs Similarly to SVD method, on average, it seems.

#### Plotted results

Go to [This Folder](https://github.com/Skyepaphora-Griffith/PhD_Proposal/tree/main/ICASSP/PaperPlots) and look for filenames beginning with `yf_`

--- 

### Smooth Spectrograms

* Plotted outer product of $\hat g$ and $\hat S_Y(f)$; estimates taken from our method
* Did this for each simulation, plotted average over all 100 smoothed spectrograms.
* Also plotted results for a single simulation
* Also plotted *un-smoothed* CBC results for comparison.

#### Plotted results

Go to [This Folder](https://github.com/Skyepaphora-Griffith/PhD_Proposal/tree/main/ICASSP/PaperPlots) and look for filenames beginning with `sx_`

---

## Paper

---

## What needs to be done

#### Standard error
When I say "normalize," I mean dividing a function (example: $\hat g$) by its maximum value, so that the normalized range maxes out at 1.

In general, I'm normalizing the average result over 100 *un-normalized* estimates. If I do it the other way around (ie: taking the average over 100 *normalized* estimates) then the final result is guaranteed to underestimate the true function. How do I calculate the standard error according to this method? I don't think it's correct to simply take the average standard error across all estimates and then normalize it in the same way. 

Can standard error be omitted from the plots? Do we need to comment on this in the paper?

#### references
yeah, yeah

#### rename estimates

* Unless I'm mistaken, Glen proposes we call the BCMTFSE and CBCMTFSE the 1-BC and 2-BC, respectively (and for general polynomials of order $p$, the $p$-BC). My issue with this: the $p$-"Boundary Corrected" *what?* We talked forever about how spectrograms are TFS estimates and you said to take out the word spectrogram, but now it's just $p$-"Boundary Corrected" which means nothing out of context.
* What do we call our $\hat g$? What do we call our $\hat Y$?
* I'm calling the new spectrogram the "Time Smoothed" Spectrogram. Time smoothing can apply to any spectrogram of a UMP.

#### Formatting

* the titles suck, I know, please help
* why is Wesley's name and info weirdly offset? 
* make equations small enough to fit in a column









