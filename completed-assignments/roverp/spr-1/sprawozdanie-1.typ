#set text(lang: "pl", size: 11pt)
#set page(paper: "a4", margin: auto, numbering: "1")
#set par(justify: true)
#set heading(numbering: "1.1")

#align(center)[
  #text(size: 1.5em, weight: "bold")[
    Sprawozdanie nr 1
  ]

  #v(1em)

  #text(size: 1.2em)[
    Modelowanie i Symulacja Komputerowa
  ]

  #v(3em)

  #text()[
    Yaroslav Zubakha \
    121546 \
    gr 2 \
    #datetime.today().display()
  ]
]

#pagebreak()

#outline(title: "Spis terści", indent: auto)
#pagebreak()

= Zadanie 1.1 - Modelowanie obwodu RLC

== Treść zadania

Zamodelować przebieg napięcia oraz prądu na kondensatorze w stanie nieustalonym dla obwodu RLC.

#v(1em)

*Dane do obliczeń:*

- Wariant 1: $E = 4 + X = 8 V$, $R = 1 Omega$, $L = 3 H$, $C = 1 F$
- Wariant 2: $E = 4 + Y = 10 V$, $R = 0 Omega$, $L = 3 H$, $C = 1 F$

#v(1em)

*Parametry symulacji:*

- Krok: $h = 0.01 s$
- Czas: $T_"kon" = 30 s$

#v(1.5em)

== Model matematyczny

Równanie obwodu RLC według prawa Kirchhoffa:

$ R * i(t) + L * (d i(t)) / (d t) + u_c (t) = e(t) $

gdzie prąd przez kondensator:

$ i(t) = C * (d u_c (t)) / (d t) $

Po podstawieniu i przekształceniach otrzymujemy równanie różniczkowe drugiego rzędu:

$ (d^2 u_c) / (d t^2) = (E - u_c - R C (d u_c) / (d t)) 1 / (L C) $

z warunkami początkowymi: $u_c (0) = 0$, $u'_c (0) = 0$

#v(1.5em)

== Model symulacyjny

#figure(
  image("sprawozdanie-1.1/model.png", width: 90%),
  caption: "Schemat blokowy modelu obwodu RLC w Xcos",
)

#v(1.5em)

== Wyniki symulacji

=== Wariant 1: $E = 8 V$, $R = 1 Omega$

#figure(
  image("sprawozdanie-1.1/result-1.png", width: 90%),
  caption: [Przebiegi $u_c (t)$ i $i(t)$ dla wariantu 1],
)

#v(1em)

=== Wariant 2: $E = 10 V$, $R = 0 Omega$

#figure(
  image("sprawozdanie-1.1/result-2.png", width: 90%),
  caption: [Przebiegi $u_c (t)$ i $i(t)$ dla wariantu 2],
)

#pagebreak()

= Zadanie 1.2 - Oscylator harmoniczny z tarciem suchym i tłumieniem

== Treść zadania

Modelowanie oscylatora harmonicznego z tarciem suchym i z tłumieniem; Zamodelować przebieg x(t)

#v(1em)

*Dane do obliczeń:*

- $m = 0.5; c = 0.2; k = 5 + Y = 11; mu = 0.02; x(0) = 1 = 0.5 + X / 20 = 0.7; g = 9.81$

#v(1em)

*Parametry symulacji:*

- Krok: $h = 0.001 s$
- Czas: $T_"kon" = 7 s$

#v(1.5em)

== Model matematyczny

Równanie ruchu według 888ii zasady dynamiki Newtona:

$
  m (d^2 x) / (d t^2) + c (d x) / (d t) + k x + mu m g dot "sign" ((d x) / (d t)) = 0
$

Postać normalna:

$
  (d^2 x) / (d t^2) = 1 / m (-c (d x) / (d t) - k x - mu m g dot "sign" ((d x) / (d t)))
$

z warunkami początkowymi: $x(0) = 0.7$, $x'(0) = 0$

#v(1.5em)

== Model symulacyjny

#figure(
  image("sprawozdanie-1.2/model.png", width: 90%),
  caption: [Schemat blokowy oscylatora z tarciem suchym w Xcos],
)

#v(1.5em)

== Wyniki symulacji

#figure(
  image("sprawozdanie-1.2/result-1.png", width: 90%),
  caption: [Przebieg $x(t)$ oscylatora z tarciem],
)

#pagebreak()

= Zadanie 1.3 - Silnik obcowzbudny prądu stałego

== Treść zadania

Zamodelować przebiegi $omega (t)$ oraz $i(t)$ dla silnika obcowzbudnego prądu stałego.

#v(1em)

*Dane znamionowe silnika:*

- $J = 2.7 "kg" dot "m"^2$
- $R = 0.465 Omega$
- $L = 0.015345 H$
- $k_e = 2.62 V dot s$
- $k_m = 2.62 "N" dot "m/A"$

#v(1em)

*Warianty obliczeń:*

- Wariant 1: $u_z = 100 V$, $m_"obc" = 100 N m$
- Wariant 2: $u_z = 108 V$, $m_"obc" = 200 N m$
- Wariant 3: $u_z = 230 V$, $m_"obc" = 100 N m$
- Wariant 4: $u_z = 242 V$, $m_"obc" = 200 N m$

#v(1em)

*Parametry symulacji:*

- Krok: $h = 0.001 s$
- Czas: $T_"kon" = 1.6 s$

#v(1.5em)

== Model matematyczny

Silnik opisany jest układem dwóch sprzężonych równań różniczkowych:

*Obwód elektryczny (twornik):*

$ (d i) / (d t) = 1 / L (u_z - k_e omega - R i) $

*Układ mechaniczny (wirnik):*

$ (d omega) / (d t) = 1 / J (k_m i - m_"obc") $

z warunkami początkowymi: $i(0) = 0$, $omega (0) = 0$

#v(1.5em)

== Model symulacyjny

#figure(
  image("sprawozdanie-1.3/model.png", width: 90%),
  caption: [Schemat blokowy silnika prądu stałego w Xcos],
)

#v(1.5em)

== Wyniki symulacji

=== Wariant 1: $u_z = 100 V$, $m_"obc" = 100 N m$

#figure(
  image("sprawozdanie-1.3/result-1.png", width: 90%),
  caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 1],
)

=== Wariant 2: $u_z = 108 V$, $m_"obc" = 200 N m$

#figure(
  image("sprawozdanie-1.3/result-2.png", width: 90%),
  caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 2],
)

=== Wariant 3: $u_z = 230 V$, $m_"obc" = 100 N m$

#figure(
  image("sprawozdanie-1.3/result-3.png", width: 90%),
  caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 3],
)

=== Wariant 4: $u_z = 242 V$, $m_"obc" = 200 N m$

#figure(
  image("sprawozdanie-1.3/result-4.png", width: 90%),
  caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 4],
)

