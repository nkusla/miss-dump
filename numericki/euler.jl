using Plots

function euler(y_prime, y0, x0, x_end, step)
	
	X = collect(x0:step:x_end)
	Y = [y0]
	while(x0 <= x_end)
		y1 = y0 + y_prime(y0, x0)*step
		y0 = y1
		x0 += step
		push!(Y, y1)
	end

	return Y, X
end

### Main ###

animation = Animation()

y_prime(y,x) = exp(-y) 			# differential equation
y_sol(x) = log(x + 1/exp(1))	# analytical solution
y0 = -1.0						# inital conditions
x0 = 0.0
x_end = 10.0
step = 1
plt_interval = x0:0.001:x_end

plt_sol = plot(y_sol, plt_interval, lw=1, label="analytical solution", legend=:bottomright)

while(step >= 0.01)
	Y, X = euler(y_prime, y0, x0, x_end, step)
	plt_final = scatter(plt_sol, X, Y, 
				title="Fixed step = $step", color=:yellow, markersize=1.5, label="numerical solution")
	frame(animation, plt_final)
	step /= 2
end

# Saving gif
dir = @__DIR__()
gif(animation, "$dir/euler.gif", fps = 2)
