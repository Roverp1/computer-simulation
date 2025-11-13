#set text(lang: "pl", size: 11pt)
#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm), numbering: "1")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")

// Strona tytułowa z innym układem
#v(4em)

#align(center)[
  #block(width: 85%)[
    #align(center)[
      #text(size: 18pt, weight: "bold")[
        SPRAWOZDANIE NR 1
      ]
    ]

    #v(2em)
    #line(length: 100%, stroke: 1pt)
    #v(1em)

    #text(size: 13pt, weight: "semibold")[
      Modelowanie i Symulacja Komputerowa
    ]

    #v(1em)
    #line(length: 100%, stroke: 1pt)
  ]
]

#v(5em)

#align(center)[
  #block(width: 60%)[
    #table(
      columns: 2,
      stroke: none,
      align: (right, left),
      row-gutter: 0.8em,
      [*Autor:*], [Maksym Mokriakov],
      [*Nr indeksu:*], [121261],
      [*Grupa:*], [2],
      [*Data:*], [#datetime.today().display()],
    )
  ]
]

#pagebreak()

#outline(title: "Spis terści", indent: auto)
#pagebreak()

= Zadanie 1.1 - Modelowanie obwodu RLC

== Treść zadania

Zamodelować przebieg napięcia oraz prądu na kondensatorze w stanie nieustalonym dla obwodu RLC.

#v(0.8em)

#block(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
)[
  *Dane do obliczeń:*

  #table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    [*Wariant*], [$bold(E)$ [V]], [$bold(R)$ [$Omega$]], [$bold(L)$ [H]], [$bold(C)$ [F]],
    [1], [8], [1], [3], [1],
    [2], [10], [0], [3], [1],
  )
]

#v(0.8em)

#block(
  fill: luma(250),
  inset: 8pt,
  radius: 4pt,
)[
  *Parametry symulacji:* Krok $h = 0.01 s$, czas symulacji $T_"kon" = 30 s$
]

#v(1.2em)

== Model matematyczny

Równanie obwodu RLC według prawa Kirchhoffa:

#align(center)[
  $ R * i(t) + L * (d i(t)) / (d t) + u_c (t) = e(t) $
]

gdzie prąd przez kondensator definiowany jest jako:

#align(center)[
  $ i(t) = C * (d u_c (t)) / (d t) $
]

Po podstawieniu oraz przekształceniach otrzymujemy równanie różniczkowe drugiego rzędu:

#block(
  fill: rgb("#f0f8ff"),
  inset: 12pt,
  radius: 5pt,
)[
  #align(center)[
    $ (d^2 u_c) / (d t^2) = (E - u_c - R C (d u_c) / (d t)) 1 / (L C) $
  ]

  #v(0.5em)
  #align(center)[
    Warunki początkowe: $u_c (0) = 0$, $u'_c (0) = 0$
  ]
]

#v(1.2em)

== Model symulacyjny

#align(center)[
  #figure(
    image("sprawozdanie-1.1/model.png", width: 88%),
    caption: "Schemat blokowy modelu obwodu RLC w Xcos"
  )
]

#v(1.2em)

== Wyniki symulacji

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 1: $E = 8 V$, $R = 1 Omega$

  #align(center)[
    #figure(
      image("sprawozdanie-1.1/result-1.png", width: 85%),
      caption: [Przebiegi $u_c (t)$ i $i(t)$ dla wariantu 1]
    )
  ]
]

#v(0.8em)

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 2: $E = 10 V$, $R = 0 Omega$

  #align(center)[
    #figure(
      image("sprawozdanie-1.1/result-2.png", width: 85%),
      caption: [Przebiegi $u_c (t)$ i $i(t)$ dla wariantu 2]
    )
  ]
]

#pagebreak()

= Zadanie 1.2 - Oscylator harmoniczny z tarciem suchym i tłumieniem

== Treść zadania

Modelowanie oscylatora harmonicznego z tarciem suchym i z tłumieniem; Zamodelować przebieg x(t)

#v(0.8em)

#block(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
)[
  *Dane do obliczeń:*

  #align(center)[
    #table(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      align: center,
      [$bold(m)$], [$bold(c)$], [$bold(k)$], [$bold(mu)$], [$bold(x(0))$], [$bold(x'(0))$], [$bold(g)$ [m/s²]],
      [0.5], [0.2], [11], [0.02], [0.7], [0], [9.81],
    )
  ]
]

#v(0.8em)

#block(
  fill: luma(250),
  inset: 8pt,
  radius: 4pt,
)[
  *Parametry symulacji:* Krok $h = 0.001 s$, czas symulacji $T_"kon" = 7 s$
]

#v(1.2em)

== Model matematyczny

Równanie ruchu według II zasady dynamiki Newtona:

#align(center)[
  $ m (d^2 x) / (d t^2) + c (d x) / (d t) + k x + mu m g dot "sign" ((d x) / (d t)) = 0 $
]

Postać normalna równania:

#block(
  fill: rgb("#f0f8ff"),
  inset: 12pt,
  radius: 5pt,
)[
  #align(center)[
    $ (d^2 x) / (d t^2) = 1 / m (-c (d x) / (d t) - k x - mu m g dot "sign" ((d x) / (d t))) $
  ]

  #v(0.5em)
  #align(center)[
    Warunki początkowe: $x(0) = 0.7$, $x'(0) = 0$
  ]
]

#v(1.2em)

== Model symulacyjny

#align(center)[
  #figure(
    image("sprawozdanie-1.2/model.png", width: 88%),
    caption: [Schemat blokowy oscylatora z tarciem suchym w Xcos]
  )
]

#v(1.2em)

== Wyniki symulacji

#align(center)[
  #figure(
    image("sprawozdanie-1.2/result-1.png", width: 88%),
    caption: [Przebieg $x(t)$ oscylatora z tarciem]
  )
]

#pagebreak()

= Zadanie 1.3 - Silnik obcowzbudny prądu stałego

== Treść zadania

Zamodelować przebiegi $omega (t)$ oraz $i(t)$ dla silnika obcowzbudnego prądu stałego.

#v(0.8em)

#block(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
)[
  *Dane znamionowe silnika:*

  #align(center)[
    #table(
      columns: 5,
      align: center,
      [$bold(J)$ [kg·m²]], [$bold(R)$ [$Omega$]], [$bold(L)$ [H]], [$bold(k_e)$ [V·s]], [$bold(k_m)$ [N·m/A]],
      [2.7], [0.465], [0.015345], [2.62], [2.62],
    )
  ]
]

#v(0.8em)

#block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)[
  *Warianty obliczeń:*

  #align(center)[
    #table(
      columns: 3,
      align: center,
      [*Wariant*], [$bold(u_z)$ [V]], [$bold(m_"obc")$ [N·m]],
      [1], [100], [100],
      [2], [108], [200],
      [3], [230], [100],
      [4], [242], [200],
    )
  ]
]

#v(0.8em)

#block(
  fill: luma(250),
  inset: 8pt,
  radius: 4pt,
)[
  *Parametry symulacji:* Krok $h = 0.001 s$, czas symulacji $T_"kon" = 1.6 s$
]

#v(1.2em)

== Model matematyczny

Silnik opisany jest układem dwóch sprzężonych równań różniczkowych:

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Obwód elektryczny (twornik):*

    #align(center)[
      $ (d i) / (d t) = 1 / L (u_z - k_e omega - R i) $
    ]
  ],
  [
    *Układ mechaniczny (wirnik):*

    #align(center)[
      $ (d omega) / (d t) = 1 / J (k_m i - m_"obc") $
    ]
  ]
)

#v(0.8em)

#block(
  fill: rgb("#f0f8ff"),
  inset: 10pt,
  radius: 5pt,
)[
  #align(center)[
    Warunki początkowe: $i(0) = 0$, $omega (0) = 0$
  ]
]

#v(1.2em)

== Model symulacyjny

#align(center)[
  #figure(
    image("sprawozdanie-1.3/model.png", width: 88%),
    caption: [Schemat blokowy silnika prądu stałego w Xcos]
  )
]

#v(1.2em)

== Wyniki symulacji

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 1: $u_z = 100 V$, $m_"obc" = 100 N m$

  #align(center)[
    #figure(
      image("sprawozdanie-1.3/result-1.png", width: 85%),
      caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 1]
    )
  ]
]

#v(0.8em)

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 2: $u_z = 108 V$, $m_"obc" = 200 N m$

  #align(center)[
    #figure(
      image("sprawozdanie-1.3/result-2.png", width: 85%),
      caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 2]
    )
  ]
]

#v(0.8em)

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 3: $u_z = 230 V$, $m_"obc" = 100 N m$

  #align(center)[
    #figure(
      image("sprawozdanie-1.3/result-3.png", width: 85%),
      caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 3]
    )
  ]
]

#v(0.8em)

#block(
  stroke: 0.5pt + luma(180),
  inset: 8pt,
  radius: 3pt,
)[
  === Wariant 4: $u_z = 242 V$, $m_"obc" = 200 N m$

  #align(center)[
    #figure(
      image("sprawozdanie-1.3/result-4.png", width: 85%),
      caption: [Przebiegi $i(t)$ i $omega (t)$ dla wariantu 4]
    )
  ]
]

