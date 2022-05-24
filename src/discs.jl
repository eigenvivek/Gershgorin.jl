using LinearAlgebra
using Plots


function get_discs(A::AbstractMatrix)
    centers = diag(A) |> complex
    radii = A - Diagonal(A) |> M -> sum(M, dims=2) |> x -> abs.(x) |> real
    return centers, radii[:]
end


function disc_shape(c::T, r::S) where {T<:Complex,S<:Real}
    θ = LinRange(0, 2 * π, 100)
    return c.re .+ r * sin.(θ), c.im .+ r * cos.(θ)
end


function plot_disc(centers::Vector{T}, radii::Vector{S}) where {T<:Complex,S<:Real}
    plot(disc_shape.(centers, radii), seriestype=[:shape],
        c=:blue, fillalpha=0.2, lw=0,
        xlabel="Real Axis", ylabel="Imaginary Axis",
        legend=false, aspect_ratio=1)
end


function gershgorin(A::AbstractMatrix)
    centers, radii = get_discs(A)
    plot_disc(centers, radii) |> display
end