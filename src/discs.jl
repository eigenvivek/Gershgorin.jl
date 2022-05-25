using LinearAlgebra
using Plots, LaTeXStrings


function get_discs(A::AbstractMatrix)
    centers = diag(A) |> complex
    radii = A - Diagonal(A) |> x -> abs.(x) |> M -> sum(M, dims=2) |> real
    return centers, radii[:]
end


function disc_shape(center::T, radius::S) where {T<:Complex,S<:Real}
    θ = LinRange(0, 2 * π, 100)
    # @. disc = c + r * exp(im * θ)
    return center.re .+ radius * sin.(θ), center.im .+ radius * cos.(θ)
end


function parse_label(label::Union{String,LaTeXString}, dim::Int)
    if label == ""
        return ""
    else
        return reshape([i == 1 ? label : nothing for i in 1:dim][:, :], (1, dim))
    end
end


function plot_disc(centers::Vector{T}, radii::Vector{S}, c::Symbol, label::Union{String,LaTeXString}) where {T<:Complex,S<:Real}
    plot(disc_shape.(centers, radii), seriestype=[:shape],
        c=c, fillalpha=0.2, lw=0,
        xlabel="Real Axis", ylabel="Imaginary Axis", label=parse_label(label, length(centers)),
        legend=false ? label == "" : true, aspect_ratio=1)
end

function plot_disc!(centers::Vector{T}, radii::Vector{S}, c::Symbol, label::Union{String,LaTeXString}) where {T<:Complex,S<:Real}
    plot!(disc_shape.(centers, radii), seriestype=[:shape],
        c=c, fillalpha=0.2, lw=0,
        xlabel="Real Axis", ylabel="Imaginary Axis", label=parse_label(label, length(centers)),
        legend=false ? label == "" : true, aspect_ratio=1)
end


function gershgorin(A::AbstractMatrix; c=:blue, label="")
    centers, radii = get_discs(A)
    plot_disc(centers, radii, c, label)
end

function gershgorin!(A::AbstractMatrix; c=:red, label="")
    centers, radii = get_discs(A)
    plot_disc!(centers, radii, c, label)
end