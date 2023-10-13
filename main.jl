using Plots

π_C_NSG(k, M, b, c) = 1 ≤ k < M ? -c/M : b - c/k
π_D_NSG(k, M, b, c) = 0 ≤ k < M ? 0 : b

f_C(k, Z, N, M, b, c) = 1/binomial(Z-1, N-1) * sum(binomial(k-1, j) * binomial(Z-k, N-j-1) * π_C_NSG(j+1, M, b, c) for j in 0:(N-1))
f_D(k, Z, N, M, b, c) = 1/binomial(Z-1, N-1) * sum(binomial(k, j) * binomial(Z-k-1, N-j-1) * π_D_NSG(j, M, b, c) for j in 0:(N-1))

Δf(k, Z, N, M, b, c) = f_C(k, Z, N, M, b, c) - f_D(k, Z, N, M, b, c)

p₋(k, Z, β, N, M, b, c) = 1 / (1 + exp(β * Δf(k, Z, N, M, b, c)))
p₊(k, Z, β, N, M, b, c) = 1 / (1 + exp(-β * Δf(k, Z, N, M, b, c)))

T₋(k, Z, μ, β, N, M, b, c) = k / Z * ((Z-k)/(Z-1) * p₋(k, Z, β, N, M, b, c) * (1-μ) + μ)
T₊(k, Z, μ, β, N, M, b, c) = (Z-k) / Z * (k/(Z-1) * p₊(k, Z, β, N, M, b, c) * (1-μ) + μ)

G(k, Z, μ, β, N, M, b, c) = T₊(k, Z, μ, β, N, M, b, c) - T₋(k, Z, μ, β, N, M, b, c)

k = 10; Z = 100; μ = 0.0; β = 1.0; N = 10; M = 5; b = 1.; c = 0.2
f(k) = G(k, Z, μ, β, N, M, b, c)

x = 0:Z
y = f.(x)
plot(x, y)