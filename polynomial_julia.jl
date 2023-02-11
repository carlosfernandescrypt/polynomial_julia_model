using Statistics

function polyfit(x::Array{Float64, 1}, y::Array{Float64, 1}, degree::Int)
    X = ones(length(x), degree + 1)
    for i = 1:degree
        X[:, i + 1] = x .^ i
    end
    return (X'X) \ (X'y)
end

function polyval(w, x)
    y = zeros(length(x))
    for i = 1:length(w)
        y += w[i] * x .^ (i - 1)
    end
    return y
end

function mean_squared_error(y_true, y_pred)
    return mean((y_true - y_pred) .^ 2)
end

#### generate toy data
x = range(0, stop=10, length=100)
y = sin.(2 * pi * x) + randn(length(x)) * 0.1

degree = 9
w = polyfit(x, y, degree)
y_pred = polyval(w, x)

println("Mean squared error: $(mean_squared_error(y, y_pred))")
