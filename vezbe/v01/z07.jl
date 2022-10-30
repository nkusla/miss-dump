#=
Za podatke iz tabele T napisati kod koji određuje:
	- koliko je ženskih, a koliko muških osoba (poželjno je prikazati i njihova imena),
	- prosečnu visinu i težinu ženskih osoba,
	- prosečnu visinu i težinu muških osoba,
	- najstariju i najmlađu osobu,
	- standardnu devijaciju za visinu.
=#

using LinearAlgebra, Statistics

T = ["Ime" "Pol" "Starost" "Tezina" "Visina";
"Ana" "z" 20 46 160;
"Bojan" "m" 24 52 165;
"Vlada" "m" 24 95 195;
"Gordana" "z" 30 57 160;
"Dejan" "m" 36 84 185;
"Zoran" "m" 22 80 180]

T = T[2:end, :]

# broj muskih i zenskih
ind_m = findall(T[:, 2] .== "m")
ind_z = findall(T[:, 2] .== "z")
muskih = T[ind_m, 1]
zenskih = T[ind_z, 1]

println("Muske osobe: ", muskih)
println("Broj muskih osoba: " , size(muskih, 1) , "\n")
println("Zenske osobe: ", zenskih)
println("Broj zenskih osoba: " , size(zenskih, 1) , "\n")

# prosecne tezine i visine
avg_tezina_m = mean(T[ind_m, 4])
avg_visina_m = mean(T[ind_m, 5])
avg_tezina_z = mean(T[ind_z, 4])
avg_visina_z = mean(T[ind_z, 5])

ispis = ["Pol" "Tezina" "Visina"]
ispis = [ispis; ["M" avg_tezina_m avg_visina_m]]
ispis = [ispis; ["Z" avg_tezina_z avg_visina_z]]

display(ispis)
println()

# najstarija i najmladja osoba
najstariji = maximum(T[:, 3])
najmladji = minimum(T[:, 3])

ind_najstariji = findall(T[:, 3] .== najstariji)
ind_najmladji = findall(T[:, 3] .== najmladji)

println("Najstarije osobe su: ", T[ind_najstariji, 1])
println("Najmladje osobe su: ", T[ind_najmladji, 1])

# standardna devijacija
visine = T[:, 5]
m = mean(visine)
N = size(T, 2)
((visine .- m) .^ 2) ./ N
sigma = sqrt(sum(visine))

println("Standardna divijacija: ", sigma)
