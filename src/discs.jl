using LinearAlgebra
using LazySets
using Plots, LaTeXStrings

complex2array(x::T) where {T<:Complex} = [x.re, x.im]

function get_discs(A::AbstractMatrix)
    centers = diag(A) |> complex |> x -> complex2array.(x)
    radii = A - Diagonal(A) |> x -> abs.(x) |> M -> sum(M, dims=2) |> real
    discs = [Ball2(c, r) for (c, r) in zip(centers, radii)]
    return discs
end


function parse_label(label::Union{String,LaTeXString}, dim::Int)
    if label == ""
        nothing
    else
        label = reshape([i == 1 ? label : nothing for i in 1:dim][:, :], (1, dim))
    end
    return label
end


function gershgorin(A::AbstractMatrix; c=:blue, label="", alpha=0.2)
    discs = get_discs(A)
    label = parse_label(label, length(discs))
    legend = label == "" ? false : true
    plot(discs, c=c, fillalpha=alpha, lw=0, aspect_ratio=1,
        legend=legend, label=label,
        xlabel="Real Axis", ylabel="Imaginary Axis")
end


function gershgorin(A::AbstractMatrix; c=:blue, label="")
    centers, radii = get_discs(A)
    plot_disc(centers, radii, c, label)
end

function gershgorin!(A::AbstractMatrix; c=:red, label="")
    centers, radii = get_discs(A)
    plot_disc!(centers, radii, c, label)
end