# Gershgorin

## Quickstart Guide

We can visualize the Gershgorin discs for a random complex matrix and its transpose.
Note that a matrix and its transpose have the same eigenvalues, so these eigenvalues will lie in the intersection of the Gershgorin regions of these two matrices.

```Julia
using LinearAlgebra
using Plots, LaTeXStrings
using Gershgorin

# Make a random (5,5) real matrix
M = randn(5, 5)

# Plot Gershgorin's discs
gershgorin(M; c=:blue, label=L"$M$")
λ = eigvals(M)
p1 = plot!(λ, seriestype=[:scatter], c=:black, label=L"$\lambda(M)$")

# Now do the same for the transpose
gershgorin(transpose(M); c=:red, label=L"$M^T$")
λ = eigvals(transpose(M))
p2 = plot!(λ, seriestype=[:scatter], c=:black, label=L"$\lambda(M^T)$")

# Plot the intersection between the two sets of regions
gershgorin(M; c=:blue)
gershgorin!(transpose(M); c=:red)
overlap(M, transpose(M), c=:black, alpha=1)
p3 = plot!(λ, seriestype=[:scatter], c=:black, label=L"$\lambda(M)$")

plot(p1, p2, p3, link=:all, dpi=300, layout=(1,3), size=(750,350))
```

![`gershgorin(M)`](notebooks/demo.png "Gershgorin's discs for M and its transpose")

Additionally, if you just want to get the Gershgorin discs for a matrix, you can use the `get_discs` function.

```Julia
discs = get_discs(M)
plot(discs, c=:blue, alpha=0.2, lw=0)
plot!(eigvals(M), seriestype=[:scatter], c=:black, label=L"$\lambda(M)$", aspect_ratio=1) |> display
```

![`get_discs(M)`](notebooks/demo1.png "Get the discs")
