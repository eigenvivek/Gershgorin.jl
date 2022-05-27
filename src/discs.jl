using LinearAlgebra
using LazySets
using Plots, LaTeXStrings

complex2array(x::T) where {T<:Complex} = [x.re, x.im]

function get_discs(A::AbstractMatrix)
    centers = diag(A) .|> Complex .|> complex2array
    radii = A - Diagonal(A) .|> abs |> M -> sum(M, dims=2) .|> Real
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


function gershgorin!(A::AbstractMatrix; c=:blue, label="", alpha=0.2)
    discs = get_discs(A)
    label = parse_label(label, length(discs))
    legend = label == "" ? false : true
    plot!(discs, c=c, fillalpha=alpha, lw=0, aspect_ratio=1,
        legend=legend, label=label,
        xlabel="Real Axis", ylabel="Imaginary Axis")
end


function overlap(A::AbstractMatrix, B::AbstractMatrix; c=:white, alpha=0.8, label="Overlap")
    discs_A = get_discs(A)
    discs_B = get_discs(B)
    intersections = [discs_A[i] ∩ discs_B[j] for i in 1:length(discs_A) for j in 1:length(discs_B)]
    overlap = UnionSetArray(intersections)
    plot!(overlap, aspect_ratio=1, lw=0, c=c, fillalpha=alpha, label=label, legend=true)
end

