using Plots

function bisection(f, x_left, x_right, error, plt_f, animation)
	printstyled("Iterations: \n", color=:yellow)

	if(f(x_left)*f(x_right) > 0)
		return NaN
	end

	k = 0
	middle = (x_left + x_right)/2.0

	while(abs(x_left - x_right) >= error)

		# Ploting and animiation part
		plt_temp = scatter(plt_f, [x_left, x_right], [f(x_left), f(x_right)], 
						markersize=3, color=:red, label=false)

		plot!(plt_temp, [x_left, x_left], [0, f(x_left)], 
				color=:red, lw=1, label=false)
		plot!(plt_temp, [x_right, x_right], [0, f(x_right)], 
				color=:red, lw=1, label=false)
		
		frame(animation, plt_temp)

		# Core algorithm
		middle = (x_left + x_right)/2.0
		f(x_right)*f(middle) > 0 ? x_right = middle : x_left = middle

		# Output
		println("$k:  $middle")
		k += 1
	end

	return middle
end

### Main ###

animation = Animation()

f(x) = x^3 + x + 1
x_left = -3
x_right = 3
plt_interval = -4:0.01:4
error = 1e-3

# Creating plot of function and x-axis
plt_f = plot(f, plt_interval, xticks=-4:0.5:4, lw=3, label=false)
plot!(plt_f, (x) -> 0, plt_interval, lw=1, color=:gray, label=false)
frame(animation, plt_f)

printstyled("--- Bisection method ---\n\n", color=:cyan)
solution = bisection(f, x_left, x_right, error, plt_f, animation)
printstyled("\nSolution: ", color=:yellow)
print(solution)

# Saving gif
gif(animation, replace(@__FILE__(), ".jl" => ".gif"), fps=2, show_msg=false)
