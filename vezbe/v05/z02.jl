using DifferentialEquations, Plots

function f(t)
	
end

function sistem!()
	
end

t=0:0.01:10
plot(t, f.(t))

# Crtanje svih grafika
plt_final = plot(plt_F)
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z01.png")