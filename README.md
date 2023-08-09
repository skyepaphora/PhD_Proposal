### TFS Estimators

The file *CBC_Simulations.Rmd* produces a simulated ensemble of time series, and estimates the time-frequency spectra (TFS) of each series. 


### Which estimates?

**BCTMFSE:** The **B**oundary **C**orrected **M**odified **T**ime **F**requency **S**pectrum **E**stimate

**CBCMTFSE** The *Curvy* version of the BCMTFSE

Both estimates are based on a smoothed version of a multitaper-based TFS estimate, 
called the *Sliding Window High Resolution Spectrogram.*


### What time series are we working with?

These estimates are flexible, aimed at general non-stationary series. For the simulations which produced the plots in the "Plot" folder of this repository, we simulate the UMP, $X(t)$:

$$
\begin{aligned}
    X(t) &= \left( 2 - \exp\left[\frac{-(t-500)^2}{2(200)^2}\right] \right) Y(t)  \\ &\, \\
    Y(t) &= 0.8\,Y(t-1) - 0.4\,Y(t-2) + z(t)                                      \\ &\, \\
    z(t) &= w\big(0,\;\sigma_z^2 = 10^4\big).
\end{aligned}
$$

Above, note that $Y$ is a stationary AR(2) process, and $z$ is purely white noise.


### What are the plots?

The Spectrograms are self explanatory, for the most part. If details such as series type (noise, UMP, etc.) or blockwidth (B) aren't labeled on the plot itself, they can be found in the filename.

The animatied GIFs present the horizontal "slices" of a given spectrogram (that is, the frequency-domain slices) in sequence with respect to time.

















