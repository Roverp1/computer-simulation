#set text(lang: "pl", size: 12pt)
#set page(paper: "a4", margin: (top: 3cm, bottom: 3cm, left: 2.5cm, right: 2.5cm), numbering: "1")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.")

// Strona tytułowa z innym układem
#v(3em)

#align(center)[
  #text(size: 20pt, weight: "bold")[
    SPRAWOZDANIE NR 2
  ]
]

#v(1.5em)

#align(center)[
  #text(size: 14pt)[
    Modelowanie i Symulacja Komputerowa
  ]
]

#v(1em)
#align(center)[
  #line(length: 70%, stroke: 2pt)
]

#v(6em)

#align(center)[
  #block(width: 70%)[
    #table(
      columns: 2,
      stroke: none,
      align: (right, left),
      row-gutter: 1em,
      column-gutter: 2em,
      [*Autor:*], [Yaroslav Zubakha],
      [*Nr indeksu:*], [121546],
      [*Grupa:*], [2],
      [*Data:*], [#datetime.today().display()],
    )
  ]
]

#pagebreak()

#outline(title: "Spis terści", indent: auto)
#pagebreak()

= Zadanie 2.1 - Modelowanie obiektu opisanego równaniem różniczkowym

== Treść zadania

Zamodelować obiekt opisany równaniem różniczkowym drugiego rzędu z funkcją nieliniową. Sporządzić wykresy x(t), x'(t) oraz portret fazowy.

#v(0.8em)

#block(
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 6pt,
  width: 100%,
)[
  *Równanie różniczkowe:*

  #align(center)[
    $ (d^2 x) / (d t^2) = 2 cos(t/2) - x^2 - x' / 5 $
  ]
]

#v(1em)

#block(
  fill: rgb("#f5f5dc"),
  inset: 12pt,
  radius: 6pt,
)[
  *Warunki początkowe:*

  Dla indeksu 121546: $X = 4$ (przedostatnia cyfra)

  #align(center)[
    #table(
      columns: 2,
      align: center,
      [$bold(x(0))$], [$bold(x'(0))$],
      [0], [0.4 + X/10 = 0.4 + 0.4 = 0.8],
    )
  ]
]

#v(0.8em)

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 6pt,
)[
  *Parametry symulacji:* Krok $h = 0.01 s$, czas symulacji $T_"kon" = 10 s$
]

#v(1.2em)

== Model matematyczny

Równanie różniczkowe drugiego rzędu w postaci normalnej:

#block(
  fill: rgb("#e6f3ff"),
  inset: 14pt,
  radius: 6pt,
)[
  #align(center)[
    $ (d^2 x) / (d t^2) = 2 cos(t/2) - x^2 - 1/5 (d x) / (d t) $
  ]

  #v(0.7em)
  #align(center)[
    Warunki początkowe: $x(0) = 0$, $x'(0) = 0.8$
  ]
]

#v(1.2em)

== Modele symulacyjne

=== Wariant 1: Bez użycia bloku Expression

#align(center)[
  #figure(
    image("spr-2.1/model-2.1.1.png", width: 90%),
    caption: "Schemat blokowy modelu bez bloku Expression"
  )
]

#v(1.2em)

=== Wariant 2: Z użyciem bloku Expression

#align(center)[
  #figure(
    image("spr-2.1/model-2.1.2.png", width: 90%),
    caption: "Schemat blokowy modelu z blokiem Expression (uproszczony)"
  )
]

#pagebreak()

== Wyniki symulacji

=== Wariant 1: Model bez bloku Expression

#align(center)[
  #figure(
    image("spr-2.1/result-2.1.1.png", width: 92%),
    caption: [Przebiegi $x(t)$, $x'(t)$ oraz portret fazowy - wariant 1]
  )
]

#v(1.2em)

=== Wariant 2: Model z blokiem Expression

#align(center)[
  #figure(
    image("spr-2.1/result-2.1.2.png", width: 92%),
    caption: [Przebiegi $x(t)$, $x'(t)$ oraz portret fazowy - wariant 2]
  )
]

#v(1.2em)

=== Analiza wyników

Oba warianty modelu dają identyczne wyniki, co potwierdza poprawność implementacji. Portret fazowy pokazuje trajektorię stanu układu w przestrzeni $(x, x')$.

#pagebreak()

= Zadanie 2.2 - Modelowanie układu równań różniczkowych

== Treść zadania

Zamodelować obiekt opisany układem dwóch sprzężonych równań różniczkowych. Sporządzić wykresy zmiennych stanu oraz portret fazowy.

#v(0.8em)

#block(
  fill: rgb("#e8f4f8"),
  inset: 12pt,
  radius: 6pt,
  width: 100%,
)[
  *Układ równań różniczkowych:*

  #align(center)[
    $ (d y) / (d t) + y + 3x = 0 $
  ]

  #align(center)[
    $ (d^2 x) / (d t^2) + 0.8 (d x) / (d t) - 0.3y + 0.2x = 0 $
  ]
]

#v(1em)

#block(
  fill: rgb("#f5f5dc"),
  inset: 12pt,
  radius: 6pt,
)[
  *Warunki początkowe:*

  Dla indeksu 121546: $X = 4$ (przedostatnia cyfra), $Y = 6$ (ostatnia cyfra)

  #align(center)[
    #table(
      columns: 3,
      align: center,
      [$bold(y(0))$], [$bold(x(0))$], [$bold(x'(0))$],
      [0], [X/3 = 4/3 ≈ 1.33], [0.6 + Y/2 = 0.6 + 3 = 3.6],
    )
  ]
]

#v(1em)

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 6pt,
)[
  *Parametry symulacji:* Krok $h = 0.01 s$, czas symulacji $T_"kon" = 40 s$
]

#v(1.2em)

== Model matematyczny

Układ równań w postaci normalnej:

#block(
  fill: rgb("#e6f3ff"),
  inset: 14pt,
  radius: 6pt,
)[
  #align(center)[
    $ (d y) / (d t) = -y - 3x $
  ]

  #align(center)[
    $ (d^2 x) / (d t^2) = -0.8 (d x) / (d t) + 0.3y - 0.2x $
  ]

  #v(0.7em)
  #align(center)[
    Warunki początkowe: $y(0) = 0$, $x(0) = 1.33$, $x'(0) = 3.6$
  ]
]

#pagebreak()

== Modele symulacyjne

=== Wariant 1: Bez użycia bloku Expression

#align(center)[
  #figure(
    image("spr-2.2/model-2.2.1.png", width: 90%),
    caption: "Schemat blokowy układu równań bez bloku Expression"
  )
]

#v(1.2em)

=== Wariant 2: Z użyciem bloków Expression

#align(center)[
  #figure(
    image("spr-2.2/model-2.2.2.png", width: 90%),
    caption: "Schemat blokowy układu równań z blokami Expression (uproszczony)"
  )
]

#pagebreak()

== Wyniki symulacji

=== Wariant 1: Przebiegi x(t) i x'(t)

#align(center)[
  #figure(
    image("spr-2.2/result-2.2.1-first.png", width: 92%),
    caption: [Przebiegi $x(t)$, $x'(t)$ oraz portret fazowy]
  )
]

#v(1.2em)

=== Wariant 1: Przebiegi y(t) i y'(t)

#align(center)[
  #figure(
    image("spr-2.2/result-2.2.1-second.png", width: 92%),
    caption: [Przebiegi $y(t)$ i $y'(t)$]
  )
]

#pagebreak()

=== Wariant 2: Model z blokami Expression

#align(center)[
  #figure(
    image("spr-2.2/result-2.2.2.png", width: 92%),
    caption: [Przebiegi wszystkich zmiennych stanu - wariant 2]
  )
]

#v(1.2em)

=== Analiza wyników

Układ równań wykazuje zachowanie oscylacyjne z tłumieniem. Wartości początkowe $x(0) = 1.33$ i $x'(0) = 3.6$ wpływają na amplitudę początkowych oscylacji. Oba warianty implementacji dają identyczne wyniki.

#pagebreak()

= Zadanie 2.3 - Nieliniowy układ regulacji temperatury

== Treść zadania

Zamodelować strukturalny, nieliniowy układ stabilizacji temperatury z elementem histerezowym. Sporządzić wykresy temperatury T(t) oraz błędu regulacji ΔT(t).

#v(0.8em)

#block(
  fill: rgb("#f5f5dc"),
  inset: 12pt,
  radius: 6pt,
)[
  *Parametry układu:*

  Dla indeksu 121546: $X = 4$ (przedostatnia cyfra), $Y = 6$ (ostatnia cyfra)

  #align(center)[
    #table(
      columns: 4,
      align: center,
      [$bold(T_1)$ [°C]], [$bold(K_o)$ [°C/rad]], [$bold(T_o)$ [s]], [$bold(K_1)$ [A·zw/°C]],
      [1 + Y = 7], [25], [2.5], [25],
    )
  ]

  #align(center)[
    #table(
      columns: 3,
      align: center,
      [$bold(K_2)$ [rad/s]], [$bold(K_3)$], [$bold(K_"sz")$ [A·zw/rad]],
      [2 + Y/2 = 5], [0.1], [2.5 - X/5 = 1.7],
    )
  ]
]

#v(1em)

#block(
  fill: rgb("#fff4e6"),
  inset: 10pt,
  radius: 6pt,
)[
  *Parametry symulacji:* Krok $h = 0.005 s$, czas symulacji $T_"kon" = 20 s$
  
  Warunki początkowe zerowe
]

#v(1.2em)

== Model matematyczny

Układ regulacji temperatury składa się z następujących elementów:

#block(
  fill: rgb("#e6f3ff"),
  inset: 14pt,
  radius: 6pt,
)[
  *Element histerezowy:*

  #align(center)[
    $ u(w) = cases(
      1 "gdy" w > 0.18,
      "histereza" "gdy" |w| <= 0.18,
      -1 "gdy" w < -0.18
    ) $
  ]

  *Równania układu:*

  - Błąd regulacji: $Delta T = T - T_1$
  - Obiekt regulowany: $T(s) = K_o / (T_o s + 1)$
  - Sprzężenie zwrotne: wzmocnienia $K_1$, $K_2$, $K_3$, $K_"sz"$
]

#pagebreak()

== Model symulacyjny

#align(center)[
  #figure(
    image("spr-2.3/model-2.3.1.png", width: 93%),
    caption: "Schemat blokowy układu regulacji temperatury z histerezą"
  )
]

#v(1.2em)

== Wyniki symulacji

#align(center)[
  #figure(
    image("spr-2.3/result-2.3.1.png", width: 93%),
    caption: [Przebiegi temperatury $T(t)$ i błędu regulacji $Delta T(t)$]
  )
]

#v(1.2em)

=== Analiza wyników

Układ regulacji stabilizuje temperaturę wokół wartości zadanej $T_1 = 7 degree C$. Element histerezowy powoduje oscylacje temperatury w zakresie określonym przez strefę nieczułości $|w| <= 0.18$. Błąd regulacji $Delta T$ zmienia się cyklicznie, co jest charakterystyczne dla regulatorów dwupołożeniowych z histerezą.
