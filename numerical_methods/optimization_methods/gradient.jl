using Plots

using Plots

function gradient(func, jaccobean, x0, h, epsilon)
	x = x0
	J = loss = Inf
	step = 0.0
	X = [x0]

	while loss > epsilon
		J = jaccobean(x...)	# ... does unpacking
		f = func(x...)
		step = -h * J' * f
		loss = 0.5 * f' * f	# Loss function

		x += step
		push!(X, x)
	end

	return X
end

### Main ###

animation = Animation()

# System of nonlinear algebraic equations
func(x1, x2) = [
	2*x1 - x2 - exp(-x1) + 1;
	-x1 + 4*x2 + exp(-x2) - 2;
]

jaccobean(x1, x2) = [
	exp(-x1)+2 -1;
	-1 4-exp(-x2);
]

loss(x1, x2) = 0.5 * func(x1, x2)' * func(x1, x2)

x0 = [6.5, 3.0]
x_range = -2.0:0.1:8.0
y_range = -3.0:0.1:3.0
h = 0.1
epsilon = 1e-12

# Ploting contour plot of square function Loss
plt_contour = contour(x_range, y_range, loss)

# Caclulating optimum
X = gradient(func, jaccobean, x0, h, epsilon)

# Making animation
X1 = []
X2 = []
for x in X
	push!(X1, x[1])
	push!(X2, x[2])

	plt = plot(plt_contour, X1, X2, color=:green, label=false)	# tracing line
	scatter!(plt, [x[1]], [x[2]], color=:green, label="optimum")
	frame(animation, plt)
end

# Saving gif
gif(animation, replace(@__FILE__, ".jl" => ".gif"), fps=4, show_msg=false)
