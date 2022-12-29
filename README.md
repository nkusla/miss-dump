# MiSS repozitorijum

U ovom repozitorijumu se nalaze rešenja zadataka sa računarskih vežbi iz predmeta *Modeliranje i simulacija sistema*. Pored toga repozitorijum sadrži neke lične projekte koji su rađeni tokom semestra, nevezano za gradivo predmeta. Sve je napisano u programskom jeziku [Julia](https://docs.julialang.org).

Za pokretanje Julia fajlova potrebno je otvoriti **REPL** okruženje i instalirati sledeće pakete:

- [Plots](https://docs.juliaplots.org/stable/)
- [DifferentialEquations](https://diffeq.sciml.ai/stable/)
- [ControlSystems](https://juliacontrol.github.io/ControlSystems.jl/dev/)
- [ProgressBars](https://juliapackages.com/p/progressbars)

Ili pokrenuti fajl `install.jl`.

## Literatura i izvori

Svi tekstovi zadatak i materijali sa vežbi se nalaze na sajtu katedre za *[Automatiku](http://www.automatika.ftn.uns.ac.rs/nastavni-materijali-miss)*.

## N-body simulacija

Implementirana jednostavna simulacija sistema sa N čestica. Korišćen Njutnov zakon gravitacije i numerički metod za integraciju Njutnovih jednačina kretanja u klasičnoj mehanici. Pored toga implementirana i detekcija sudara, gde se dve ili više čestica sabija u jednu. Izvorni kod se nalazi u direktorijumu `n_body/`

| 2-body sistem | 3-body sistem |
| :---: | :---: |
| ![](n_body/2_body.gif) | ![](n_body/3_body.gif) |

| Sistem sa sudarima |
| :---: |
| ![](n_body/direct_collision.gif) |

## Numerički algoritmi

Implementirani numerički algoritmi za traženja korena (nula) funkcije i za rešavanje običnih diferencijalnih jednačina. Izvorni kod se nalazi u direktorijumu `numerical_methods/`

| Metod podele intervala | Njutn-Rapsonov metod |
| :---: | :---: |
| ![](numerical_methods/root_finding/bisection.gif) | ![](numerical_methods/root_finding/newton_raphson.gif) | 

|			Ojlerov metod 			||
| :---: | :---: |
| ![](numerical_methods/ode_methods/euler1.gif) | ![](numerical_methods/ode_methods/euler2.gif) |
| ![](numerical_methods/ode_methods/euler2ad.png) |