using Plots

function newton_raphson!(f, f_prime, x0, epsilon, plt_f, plt_interval, animation)
	printstyled("Iterations: \n", color=:yellow)
	
	x1 = x0
	k = 0
	while (abs(f(x0)) > epsilon)
		println("$k:  $x1")
		# plotting tangent of function f
		plt_tangent = plot(plt_f, (x) -> f(x0) + f_prime(x0)*(x - x0), 
						plt_interval, lw=1, color=:red, label=false)

		# core algorithm
		x1 = x0 - f(x0) / f_prime(x0)
		x0 = x1
		k += 1;

		# plotting intercept of tangent and x-axis 
		scatter!(plt_tangent, [x1], [0], markersize=3, color=:red, label=false)
		frame(animation, plt_tangent)
	end

	return x1
end

### Main ###

animation = Animation()

f(x) = x^3 + x + 1
f_prime(x) = 3*x^2 + 1
x0 = 3
epsilon = 1e-6
plt_interval = -3:0.01:3

# Creating initial plot
plt_f = plot(f, plt_interval, xticks=-3:0.5:3, lw=3, label=false)
plot!(plt_f, (x) -> 0, plt_interval, color=:gray, label=false)	# plotting x-axis
display(plt_f)

printstyled("--- Newton-Raphson method ---\n\n", color=:cyan)
newton_raphson!(f, f_prime, x0, epsilon, plt_f, plt_interval, animation)

# Saving gif
path = replace(@__FILE__(), ".jl" => ".gif")
gif(animation, path, fps=2, show_msg=false)
