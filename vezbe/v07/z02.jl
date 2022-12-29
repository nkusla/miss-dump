using ControlSystems, Plots

function sistem()
	G1 = tf(1, [1, 1])
	G2 = tf(1, [1, 2])
	H1 = tf(1, [1, 3])
	H2 = tf(1, [1, 4])

	G12 = series(G1, G2)
	H12 = series(H1, H2)
	
	W1 = minreal(feedback(G12, -H12))
	W2 = minreal(series(W1, 1/G1))
	W3 = minreal(series(W1, H1))

	return W1, W2, W3
end

t = 0:0.01:10
W1, W2, W3 = sistem()

u1 = sin.(t)
u2 = cos.(t)

y1, _, _ = lsim(W1, u1', t)
y2, _, _ = lsim(W2, u2', t)
y3, _, _ = step(W3, t)

y = y1' + y2' + y3'

plt = plot(t, y, label="odziv", xlabel="t", ylabel="y(t)")

savefig(plt, replace(@__FILE__(), ".jl" => ".png"))
