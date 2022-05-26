using Gershgorin
using Test

@testset "Gershgorin.jl" begin
    n = 4
    M = randn(ComplexF32, n, n)
    discs = get_discs(M)
    @test length(discs) == n
end
