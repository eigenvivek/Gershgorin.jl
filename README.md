# Gershgorin

## Quickstart Guide

First, visualize the Gershgorin discs for a random complexm matrix and its transpose:

```Julia
using LinearAlgebra
using Plots, LaTeXStrings
using Gershgorin

# Make a random (5,5) real matrix
M = randn(5, 5)

gershgorin(M; c=:blue, label=L"$M$")  # Plot Gershgorin's discs
λ = eigvals(M)
p1 = plot!(λ, seriestype=[:scatter], c=:black, label=L"$\lambda(M)$")

gershgorin(M'; c=:red, label=L"$M'$") # Now do the same for the transpose
λ = eigvals(M')
p2 = plot!(λ, seriestype=[:scatter], c=:black, label=L"$\lambda(M')$")

plot(p1, p2, link=:all)
```

![`gershgorin(M)`](notebooks/demo.png "Gershgorin's discs for M and its transpose")
