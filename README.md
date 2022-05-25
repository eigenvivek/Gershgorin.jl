# Gershgorin

## Quickstart Guide

First, visualize the Gershgorin discs for a random complexm matrix and its transpose:

```Julia
using Gershgorin

M = randn(ComplexF32, 5, 5)  # Initialize a random 5x5 complex matrix
gershgorin(M)  # Plot Gershgorin's discs
gershgorin(M') # Now do the same for the transpose
```

![`gershgorin(M)`](notebooks/gershgorin_M.png "Gershgorin's discs for M")
![`gershgorin(M')`](notebooks/gershgorin_M_transpose.png "Gershgorin's discs for M transpose")
