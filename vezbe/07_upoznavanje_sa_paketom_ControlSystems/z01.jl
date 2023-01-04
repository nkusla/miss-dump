using Plots, ControlSystems

function pobuda(t) 
	y = 2*cos(t) 
end

s = tf("s")
G = 1 / (2*s+3)		# funkcija prenosa

t = 0:0.01:20
u = pobuda.(t) 

y, t, x = lsim(G, u', t)

plt = plot(t, y', xlabel="t", ylabel="u₂(t)", label="odziv")

# Cuvanje grafika
savefig(plt, replace(@__FILE__(), ".jl" => ".png"))