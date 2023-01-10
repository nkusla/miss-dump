using ControlSystems, Plots

function sistem()
	G1 = tf(1, [1, 1])
	G2 = tf(1, [1, 2])
	G3 = tf(1, [1, 3])
	G4 = tf(1, [1, 4])

	W11 = series(G3, -G4)
	W11 = series(W11, G2)
	W11 = minreal(feedback(G1, W11))

	W12 = series(G4, -G3)
	W12 = series(W12, G1)
	W12 = minreal(feedback(W12, G2)) 

	W21 = series(G1, -G2)
	W21 = series(W21, G4)
	W21 = minreal(feedback(W21, G3))
	
	W22 = series(G3, -G1)
	W22 = series(W21, G2)
	W22 = minreal(feedback(G4, W22))

	return W11, W12, W21, W22
end

t = 0:0.01:10
W11, W12, W21, W22 = sistem()

u1, u2 = cos.(t), sin.(t)

y11, _, _ = lsim(W11, u1', t)
y12, _, _ = lsim(W12, u2', t)
y21, _, _ = lsim(W21, u1', t)
y22, _, _ = lsim(W22, u2', t)

y1 = y11' + y12'
y2 = y21' + y22'

plt = plot(t, y1, label="y1(t)", xlabel="t")
plot!(plt, t, y2, label="y2(t)")

savefig(plt, replace(@__FILE__(), ".jl" => ".png"))
