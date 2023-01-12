using Plots

rectangle(w, h, x, y) = Shape(x .+ [0,w,w,0], y .+ [0,0,h,h])

function integration_method(f, x0, y0, x_end, step, plt)
	Y = [y0]
	X = [x0]
	y = y0
	x = x0
	plt_area = deepcopy(plt)

	while(x <= x_end)
		y += f(x)*step

		# Plotting one rectangle
		plot!(plt_area, rectangle(step, f(x), x, 0.0), label=false, color=:green, opacity=0.5)

		x += step
		push!(Y, y)
		push!(X, x)
	end

	return Y, X, plt_area
end

### Main ###

animation = Animation()

y_prime(x) = (x-0.5)^3 - (x-0.5) + 0.2					# dy/dx = f(x) differential equation
y_sol(x) = 0.25*x^4 - 0.5*x^3 - 0.125*x^2 + 0.575*x 	# analytical solution
x0 = 0.0
y0 = 0.0
x_end = 1.3
step = 0.5
plt_interval = x0:0.01:x_end

# Plotting analytical solution and x-axis
plt_analytical = plot(y_sol, plt_interval, label="analytical solution", legend=:bottomright)
plot!(plt_analytical, (x) -> 0.0, plt_interval, label=false, lw=1, color=:grey)

# Plotting y_prime for area plot and x-axis
plt_prime = plot(y_prime, plt_interval, label="y'=f(x)", lw=2, color=:blue)
plot!(plt_prime, (x) -> 0.0, plt_interval, label=false, lw=1, color=:grey)

# Generating gif for different step sizes
while(step >= 0.001)
	Y, X, plt_area = integration_method(y_prime, x0, y0, x_end, step, plt_prime)

	plot!(plt_area, title="Fixed step = $step", titlefontsize=11)
	plt_numerical = scatter(plt_analytical, X, Y, label="numerical solution", color=:yellow, markersize=1.5)

	plt_final = plot(plt_area, plt_numerical, layout=(2, 1))
	frame(animation, plt_final)
	step /= 2
end

# Saving gif
gif(animation, replace(@__FILE__(), ".jl" => ".gif"), fps=2, show_msg=false)
