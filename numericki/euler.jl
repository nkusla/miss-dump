using Plots

# First order Euler method
function euler1(y_prime, y0, x0, x_end, step)
	
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

# Second order Euler method (with self correction)
function euler2(y_prime, y0, x0, x_end, step)
	X = collect(x0:step:x_end)
	Y = [y0]
	while(x0 <= x_end)
		yp = y0 + y_prime(y0, x0)*step									# calculating predicted y value
		epsilon = (y_prime(yp, x0+step) - y_prime(y0, x0)) * step/2		# calculating epsilon error
		yc = yp + epsilon												# calculating corrected y value
		y0 = yc
		x0 += step
		push!(Y, yc)
	end

	return Y, X
end

# Second order Euler method with adaptive step
function euler2ad(y_prime, y0, x0, x_end, error_threshold, step_min)
	X = [x0]
	Y = [y0]
	step = 0.5

	while(x0 <= x_end)
		yp = y0 + y_prime(y0, x0)*step
		epsilon = (y_prime(yp, x0+step) - y_prime(y0, x0)) * step/2
		yc = yp + epsilon
		change_step = false

		# Check if we need to adapt step
		if(abs(epsilon) > error_threshold)
			step /= 2
			change_step = true
			if(step < step_min) 
				step = step_min 
			end
		end

		# If epsilon is smaller than threshold error we
		# save x, y values and increase the step
		if(!change_step)
			y0 = yc
			x0 += step
			push!(X, x0)
			push!(Y, yc)
			step *= 2
		end
	end

	return Y, X
end

### Main ###

animation1 = Animation()
animation2 = Animation()

y_prime(y,x) = exp(-y) 			# differential equation
y_sol(x) = log(x + 1/exp(1))	# analytical solution
y0 = -1.0						# inital conditions
x0 = 0.0
x_end = 10.0
step = 1
step_min = 0.01
error_threshold = 0.001			# used for adaptive Euler method
plt_interval = x0:0.001:x_end

plt_sol = plot(y_sol, plt_interval, lw=1, label="analytical solution", legend=:bottomright)

# Testing all functions and creating gifs
while(step >= 0.01)
	Y, X = euler1(y_prime, y0, x0, x_end, step)
	plt_final = scatter(plt_sol, X, Y, 
				title="Euler 1st order\nFixed step = $step", titlefontsize=12, color=:yellow, markersize=1.5, label="numerical solution")
	frame(animation1, plt_final)
	step /= 2
end

step = 1
while(step >= 0.01)
	Y, X = euler2(y_prime, y0, x0, x_end, step)
	plt_final = scatter(plt_sol, X, Y, 
				title="Euler 2nd order\nFixed step = $step", titlefontsize=12, color=:yellow, markersize=1.5, label="numerical solution")
	frame(animation2, plt_final)
	step /= 2
end

step = 1
Y, X = euler2ad(y_prime, y0, x0, x_end, error_threshold, step_min)
plt_euler2ad = scatter(plt_sol, X, Y,
				title="Euler 2nd order\nAdaptive step", titlefontsize=12, color=:yellow, markersize=1.5, label="numerical solution" )

# Saving gifs and png
dir = @__DIR__()
gif(animation1, "$dir/euler1.gif", fps=2, show_msg=false)
gif(animation2, "$dir/euler2.gif", fps=2, show_msg=false)
savefig(plt_euler2ad, "$dir/euler2ad.png")
