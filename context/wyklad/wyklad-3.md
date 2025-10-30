# Wykład 3 - Modelowanie i symulacja komputerowa

**Temat:** Przykłady modeli matematycznych i ich modeli symulacyjnych. Nieliniowe układy regulacji ze sprzężeniem zwrotnym.

---

## Przykład 3.01 - Równanie różniczkowe II rzędu z wymuszeniem sinusoidalnym

### Równanie różniczkowe

```
x'' = 2 * sin(t) - (2/5) * x' - x
```

### Warunki początkowe

```
x'(0) = 0
x(0) = 0
```

### Schemat blokowy Xcos

**Struktura modelu:**

```
[CLOCK] → [SIN] → [*2] → [Σ] → [∫] → [∫] → [SCOPE]
                           ↑      │x''(t)  │x'(t)  │x(t)
                           │              │       │
                           └──[*(-2/5)]←──┤       │
                           │                      │
                           └──[*(-1)]←────────────┘
```

**Bloki:**
- Generator czasu (CLOCK)
- Blok SIN - funkcja sinus czasu
- Wzmacniacz *2
- Sumator (Σ) - trzy wejścia z odpowiednimi znakami
- Dwa integratory z warunkami początkowymi x'(0)=0, x(0)=0
- Multiplekser (MUX) do łączenia sygnałów
- Oscyloskop (SCOPE)

**Parametry bloków:**
- Wzmocnienie 2/5 z odwróconym znakiem w pętli sprzężenia zwrotnego
- Wzmocnienie 1 z odwróconym znakiem w drugiej pętli sprzężenia zwrotnego

### Wyniki symulacji

**Charakterystyka wykresów:**
- x'(t) - czerwona krzywa: oscylacje z przesunięciem fazowym względem x(t)
- x(t) - czarna krzywa: oscylacje sinusoidalne
- Obie krzywe wykazują oscylacyjny charakter z różnymi amplitudami
- Zakres czasu: t ∈ [0, 10]
- Zakres wartości: y ∈ [-4, 4]

---

## Przykład 3.02 - Równanie nieliniowe z tłumieniem kwadratowym

### Równanie różniczkowe

```
d²x/dt² = -K * sign(dx/dt) * (dx/dt)² - x
```

### Parametry

```
K = 0.1
t = (0, 20) [s]
```

### Warunki początkowe

```
x'(0) = 10
x(0) = 0
```

### Schemat blokowy Xcos

**Struktura modelu:**

```
                    ┌─────────────────────────────┐
                    │                             │
    [Σ] → [∫] → [∫] ───┐                         │
     ↑     │x''   │x'   │x                        │
     │     │      │     │                         │
     │     │      ├─→ [u²] ─→ [Π] ←─ [SIGN] ←─┐  │
     │     │      │              ↑              │  │
     └─────┘      └──────────────┴──────────────┴──┘
           ↑
           K
```

**Bloki specjalne:**
- SIGN - blok funkcji signum
- u² - blok potęgowania do kwadratu
- Π (product) - blok mnożenia
- K - wzmacniacz o wartości 0.1 z odwróconym znakiem

**Warunki początkowe integratów:**
- x'(0) = 10
- x(0) = 0

### Wyniki symulacji

**Wykres czasowy (t ∈ [0, 20]):**
- x'(t) - czarna krzywa: rozpoczyna od wartości 10, następnie oscylacje tłumione
- x(t) - czerwona krzywa: oscylacje tłumione wokół wartości 0

**Portret fazowy (x vs x'):**
- Spirala zbieżna do punktu (0, 0)
- Punkt startowy przy (0, 10)
- Ruch spiralny w kierunku środka układu współrzędnych
- Zakres: x ∈ [-4, 6], x' ∈ [-6, 10]

---

## Przykład 3.03 - Równania liniowe II rzędu

### Równanie różniczkowe

```
x'' + 3x' + 16x = 0
```

### Warunki początkowe

```
x'(0) = -0.64
x(0) = 2
```

### Postać przekształcona

```
x'' = -3x' - 16x
```

### Schemat blokowy Xcos

**Struktura:**

```
[Σ] → [∫] → [∫] → [SCOPE]
 ↑     │x''  │x'   │x
 │     │     │     │
 ├─[*(-3)]←──┤     │
 │                 │
 └─[*(-16)]←───────┘
```

**Parametry:**
- Wzmocnienie -3 dla pętli x'
- Wzmocnienie -16 dla pętli x
- Warunki początkowe: x'(0) = -0.64, x(0) = 2

### Wyniki symulacji

**Charakterystyka x(t):**
- Wartość początkowa: x(0) = 2
- Oscylacje tłumione
- Dążenie do wartości ustalonej ≈ 0
- Podregulowanie do wartości ujemnych (około -0.5)
- Czas symulacji: t ∈ [0, 4] [s]
- Zakres wartości: y ∈ [-1, 2]

---

## Przykład 3.04 - Równanie liniowe II rzędu z wymuszeniem stałym

### Równanie różniczkowe

```
3x'' + 5x' + 768x = 3158
```

### Warunki początkowe

```
x'(0) = -3
x(0) = 20
```

### Postać przekształcona

```
x'' = 3158/3 - (5/3)x' - (768/3)x
```

### Schemat blokowy Xcos

**Struktura:**

```
[3158/3] ──→ [Σ] → [∫] → [∫] → [SCOPE]
              ↑     │x''  │x'   │x
              │     │     │     │
              ├─[5/3]←────┤     │
              │                 │
              └─[768/3]←────────┘
```

**Parametry:**
- Stała wymuszająca: 3158/3 ≈ 1052.67
- Wzmocnienie -5/3 dla pętli x'
- Wzmocnienie -768/3 = -256 dla pętli x
- Warunki początkowe: x'(0) = -3, x(0) = 20

### Wyniki symulacji

**Uwaga:** Okno graficzne numer 20006

**Charakterystyka x(t):**
- Wartość początkowa: x(0) = 20
- Silnie oscylacyjny charakter
- Oscylacje o dużej częstotliwości
- Amplituda zmienia się w zakresie od około -10 do +20
- Wartość ustalona: około 4-5
- Czas symulacji: t ∈ [0, 6] [s]

---

## Przykład 3.05 - Układy równań różniczkowych liniowych

### Układ równań

```
x' - y = 0.2
y' + x' + 2x = 0
```

### Warunki początkowe

```
x(0) = 0.3
y(0) = 0.6
```

### Postać przekształcona

```
x' = y + 0.2
y' = -x' - 2x
```

### Schemat blokowy Xcos

**Struktura:**

```
[0.2] ──→ [Σ] → [∫] → [MUX] → [SCOPE]
           ↑     │x'   │x
           │     │     │
      [y]──┘     │     │
                 │     │
                 ↓     ↓
      [Σ] → [∫] ───────┤
       ↑    │y'  │y    │
       │    │          │
  [*(-2)]←──┘          │
       │               │
  [*(-1)]←─────────────┘
         (od x')
```

**Parametry:**
- Stała 0.2 na wejściu równania dla x'
- Wzmocnienie -2 dla x w równaniu na y'
- Sprzężenie zwrotne od x' do równania na y'
- Warunki początkowe: x(0) = 0.3, y(0) = 0.6

### Wyniki symulacji

**Uwaga:** Okno graficzne numer 20004

**Wykres czasowy:**
- y(t) - czarna krzywa: oscylacje tłumione, wartość początkowa 0.6
- x(t) - czerwona krzywa: oscylacje tłumione, wartość początkowa 0.3
- Obie zmienne dążą do wartości ustalonej około 0
- Podregulowanie do wartości ujemnych
- Czas symulacji: t ∈ [0, 10] [s]
- Zakres wartości: y ∈ [-0.8, 0.8]

---

## Przykład 3.06 - Równania różniczkowe nieliniowe

### Równanie różniczkowe

```
d²y/dt² = -√(y² + 5·(dy/dt)) - 0.16y³ - 10
```

### Warunki początkowe

```
y'(0) = 0
y(0) = 2
```

### Schemat blokowy Xcos

**Struktura:**

```
[10] ──→ [Σ] → [∫] → [∫] → [SCOPE]
         ↑     │y''  │y'   │y
         │     │     │     │
         │     │     │     │
    [X]←─┴─[SQRT]←[∑]     │
         │         ↑       │
    [0.16]←[u³]←───┤       │
                   │       │
              [u²]←┤       │
               ↑   │       │
               │   └───[5]─┘
               │
            [y']
```

**Bloki specjalne:**
- SQRT - blok pierwiastka kwadratowego
- u² - blok potęgowania do kwadratu
- u³ - blok potęgowania do sześcianu
- X - blok mnożenia
- Stała 10 z odwróconym znakiem
- Wzmocnienie 0.16 z odwróconym znakiem
- Wzmocnienie 5

**Warunki początkowe:**
- y'(0) = 0
- y(0) = 2

### Wyniki symulacji

**Wykres czasowy:**
- y(t) - czerwona krzywa: monotoniczny spadek z wartości 2 do około -4
- y'(t) - czarna krzywa: początkowo 0, osiąga minimum około -4, następnie powrót do 0
- Czas symulacji: t ∈ [0, 6] [s]

**Uwaga:** Okno graficzne numer 20004

---

## Przykład 3.07 - Inne rozwiązanie modelu z blokami uniwersalnymi

### Równanie różniczkowe (to samo co 3.06)

```
d²y/dt² = -√(y² + 5·(dy/dt)) - 0.16y³ - 10
```

### Warunki początkowe

```
y'(0) = 0
y(0) = 2
```

### Schemat blokowy Xcos - wersja z blokiem Expression

**Struktura uproszczona:**

```
[10] ──→ [Σ] → [∫] → [∫] → [MUX] → [SCOPE]
         ↑     │y''  │y'   │y
         │     │     │     │
         │     │     │     │
    [Π]←─┴─[SQRT]←[Expression: 5+u1²]
                          ↑
                          │
                     [y']─┘
         │
    [0.16]←[u³]←[y]
```

**Blok Expression:**
- Funkcja: `5 + u1²`
- Wejście: u1 = y'

**Wyniki:**
- Identyczne jak w przykładzie 3.06
- Wykres y(t) i y'(t) pokazuje taki sam przebieg

---

## Przykład 3.08 - Równanie nieliniowe Van der Pola

### Opis

Równanie różniczkowe nieliniowe Van der Pola opisujące powstawanie oscylacji w niektórych obwodach elektrycznych.

### Równanie różniczkowe

```
d²y/dt² = μ·(dy/dt) - μ·y²·(dy/dt) - y
```

### Parametry i warunki początkowe

```
μ = 1
y(0) = 0.4
y'(0) = 0
```

### Schemat blokowy Xcos

**Struktura:**

```
[Σ] → [∫] → [∫] → [MUX] → [SCOPE]
 ↑     │y''  │y'   │y     └→[XY Scope]
 │     │     │     │
 ├─[μ]←┤     │     │
 │     │     │     │
 └─[X]←[u²]←─┤     │
   ↑         │     │
   └───[μ]───┘     │
                   │
 └────[*(-1)]←─────┘
```

**Bloki:**
- Parametr μ (mu) podłączony w dwóch miejscach
- u² - blok potęgowania y do kwadratu
- X - blok mnożenia
- Warunki początkowe: y'(0) = 0, y(0) = 0.4

### Wyniki symulacji

**Wykres czasowy Y' i Y:**
- Oscylacje o stałej amplitudzie (cykl graniczny)
- Y' - czarna krzywa: oscylacje w zakresie [-3, 3]
- Y - czerwona krzywa: oscylacje w zakresie [-3, 3]
- Czas symulacji: t ∈ [0, 40] [s]

**Portret fazowy Y' = f(Y):**
- Cykl graniczny - zamknięta krzywa
- Spirala zbiegająca do cyklu granicznego z warunku początkowego
- Punkt startowy: (0.4, 0)
- Charakterystyczny kształt dla oscylatora Van der Pola
- Zakres: Y ∈ [-3, 3], Y' ∈ [-3, 3]

---

## Przykład 3.09 - Równania liniowe wyższych rzędów

### Równanie różniczkowe IV rzędu

```
x'''' + 0.8x''' + 0.2x'' + 0.06x' + 0.005x = -0.036
```

### Warunki początkowe

```
x'''(0) = 0
x''(0) = 0
x'(0) = 0
x(0) = 5
```

### Postać przekształcona

```
x'''' = -0.8x''' - 0.2x'' - 0.06x' - 0.005x - 0.036
```

### Schemat blokowy Xcos

**Struktura:**

```
[0.036] → [Σ] → [∫] → [∫] → [∫] → [∫] → [SCOPE]
           ↑     │     │     │     │     
           │    x'''' x''' x''  x'   x
           │     │     │     │     │
           ├[0.8]┘     │     │     │
           │           │     │     │
           ├──[0.2]────┘     │     │
           │                 │     │
           ├──[0.06]─────────┘     │
           │                       │
           └──[0.005]──────────────┘
```

**Parametry:**
- Stała -0.036 na wejściu
- Wzmocnienie -0.8 dla x'''
- Wzmocnienie -0.2 dla x''
- Wzmocnienie -0.06 dla x'
- Wzmocnienie -0.005 dla x
- Cztery integratory z warunkami początkowymi: 0, 0, 0, 5

**Dodatkowe oscyloskopy:**
- Jeden oscyloskop dla x' i x
- Drugi oscyloskop XY (portret fazowy)

**Parametry wyświetlania:**
```
Xmin = -10
Xmax = 5
Ymin = -1.5
Ymax = 0.5
```

### Wyniki symulacji

**Wykres X' i X:**
- X - czarna krzywa: spadek z wartości 5, oscylacje tłumione do wartości ustalonej około -7
- X' - niebieska krzywa: oscylacje tłumione wokół 0
- Czas symulacji: t ∈ [0, 80] [s]

**Portret fazowy X' = f(X):**
- Spirala zbieżna do punktu (-7, 0)
- Punkt startowy: (5, 0)
- Ruch spiralny w kierunku punktu ustalonego
- Zakres: X ∈ [-10, 6], X' ∈ [-1.5, 0.5]

---

## Przykład 3.11 - Równania różniczkowe liniowe o zmiennych współczynnikach

### Równanie różniczkowe

```
d²y/dt² = -4·t·(dy/dt) - (2·t)²·y - 7t
```

### Warunki początkowe

```
y'(0) = 0
y(0) = 10
```

### Schemat blokowy Xcos

**Struktura:**

```
[Σ] → [∫] → [∫] → [MUX] → [SCOPE]
 ↑     │y''  │y'   │y
 │     │     │     │
 │     │     │     │
 ├─[Π]←[4]←[t]     │
 │  ↑              │
 │  └──────────────┤ (y')
 │                 │
 ├─[Π]←[u²]←[2]←[t]│
 │  ↑              │
 │  └──────────────┘ (y)
 │
 └─[Π]←[7]←[t]
```

**Bloki specjalne:**
- Zegar (t) - generator czasu
- u² - blok potęgowania do kwadratu (dla (2t)²)
- Π (product) - bloki mnożenia
- Trzy pętle sprzężenia zwrotnego z współczynnikami zależnymi od czasu

**Parametry:**
- Współczynnik 4 dla członu z y'
- Współczynnik 2 dla członu z y (po podniesieniu do kwadratu z t)
- Współczynnik 7 dla członu wymuszającego
- Warunki początkowe: y'(0) = 0, y(0) = 10

### Wyniki symulacji

**Wykres y(t) i y'(t):**
- y(t) - czerwona krzywa: monotoniczny spadek z wartości 10 do około 0
- y'(t) - czarna krzywa: początkowo 0, osiąga minimum około -8, następnie powrót do 0
- Charakterystyczny przebieg dla układu ze zmiennymi współczynnikami
- Czas symulacji: t ∈ [0, 6] [s]
- Zakres wartości: y ∈ [-10, 10]

---

## Przykład 4.01 - Nieliniowy układ regulacji z przekaźnikiem dwupołożeniowym

### Opis układu

Zadaniem przedstawionego układu regulacji jest sprowadzenie w najkrótszym czasie sygnału x1 do wartości s oraz sygnału x2 do zera.

### Schemat blokowy układu

```
Xwe ──(+)──→ [Σ] ──eps──→ [Σ] ──w──→ [ψ(w)] ──u──→ [1/s] ──x2──→ [1/s] ──x1──→
       ↑             ↑                                  │              │
       │             │                                  │              │
       └─────────────┴──────────────[z = -1/2·|x2|·x2]──┘              │
                                                                       │
                                        (-)────────────────────────────┘
```

### Element nieliniowy - przekaźnik dwupołożeniowy z histerezą

**Charakterystyka u = ψ₁(w):**

```
u = ψ₁(w) = { -1          gdy w > 0.025
            { histereza    gdy |w| ≤ 0.025
            { 1            gdy w < -0.025
```

**Parametry histerezy:**
```
|w| = 0.025
```

**Charakterystyka graficzna:**
```
    u
    ↑
    │   ┌─────────
  1 │   │
────┼───┼────────→ w
    │       │
 -1 │───────┘
    │
```

### Nieliniowe sprzężenie zwrotne

```
z = -1/2·|x2|·x2
```

### Warunki początkowe

```
Xwe = 1
x1(0) = 0
x2(0) = 0
```

### Schemat blokowy Xcos

**Parametry bloku histereza:**
```
Set Deadband parameters:
- End of dead band: 0.18
- Start of dead band: -0.18
- switch on at: 0.025
- switch off at: -0.025
- output when on: -1
- output when off: 1
- use zero crossing: yes (1), no (0): 1
```

**Expression dla z:**
```
z = -0.5 * abs(u1) * u1
```
gdzie u1 = x2

### Wyniki symulacji

**Wykres x1(t):**
- Osiąga wartość zadaną 1 z niewielkimi oscylacjami
- Czas regulacji około 1.5 s
- Przeregulowanie minimalne
- Oscylacje ustalone wokół wartości 1

**Wykres w(t):**
- Początkowo wartość -1
- Przejście przez strefę histerezy przy t ≈ 1 s
- Oscylacje wokół wartości bliskiej 0

**Wykres u(t):**
- Przełączanie między wartościami -1 i 1
- Charakterystyczne skoki dla przekaźnika
- Oscylacje o zmniejszającej się częstotliwości

**Portret fazowy x2 vs x1:**
- Spirala zbieżna do punktu (1, 0)
- Punkt startowy: (0, 0)
- Trajektoria spiralna pokazująca proces regulacji

---

## Przykład 4.02 - Nieliniowy układ regulacji z elementem z nasyceniem

### Opis układu

Identyczny układ jak w przykładzie 4.01, ale z innym elementem nieliniowym.

### Element nieliniowy - element z nasyceniem

**Charakterystyka u = ψ₂(w):**

```
u = ψ₂(w) = { 1           gdy w < -0.025
            { -40·w       gdy |w| ≤ 0.025
            { -1          gdy w > 0.025
```

**Charakterystyka graficzna:**
```
    u
    ↑
  1 │────╲
    │     ╲
────┼──────╲──────→ w
    │       ╲
 -1 │        ────
    │
```

### Nieliniowe sprzężenie zwrotne

```
z = -1/2·|x2|·x2
```

### Warunki początkowe

```
Xwe = 1
x1(0) = 0
x2(0) = 0
```

### Schemat blokowy Xcos

**Implementacja elementu z nasyceniem:**
- Blok 1/0.025 (wzmocnienie 40)
- Blok SATURATION z granicami [-1, 1]
- Odwrócenie znaku (*-1)

**Expression dla z:**
```
z = -0.5 * abs(u1) * u1
```

### Wyniki symulacji

**Wykres x1(t):**
- Gładkie dojście do wartości zadanej 1
- Brak oscylacji (w przeciwieństwie do przykładu 4.01)
- Czas regulacji około 2.5 s

**Wykres w(t):**
- Gładki przebieg
- Monotoniczny wzrost od -1 do około 0
- Brak skoków charakterystycznych dla przekaźnika

**Wykres u(t):**
- Początkowo wartość 1 (nasycenie)
- Przejście przez strefę liniową
- Oscylacje o malejącej amplitudzie
- Dążenie do wartości bliskiej 0

**Portret fazowy x2 vs x1:**
- Spirala zbieżna do punktu (1, 0)
- Gładszy przebieg niż w przykładzie 4.01
- Mniejsza liczba zwojów spirali
- Punkt startowy: (0, 0)

---

## Przykład 4.03 - Modelowanie strukturalne układu regulacji temperatury

### Opis układu

Nieliniowy układ stabilizacji na przykładzie układu regulacji temperatury.

### Oznaczenia wielkości

**Wielkości fizyczne:**
- **T1** - zadana temperatura obiektu [°C]
- **φ** - kąt obrotu organu regulacyjnego (reduktor) [rad]
- **α** - kąt obrotu organu wykonawczego (silnik) [rad]
- **T** - rzeczywista wartość temperatury obiektu [°C]
- **ΔT** - błąd regulacji (uchyb), ΔT = T - T1 [°C]

### Schemat blokowy układu

```
T1 ─(+)─→ [Σ] ─ΔT─→ [WZMACNIACZ] ─(+)─→ [Σ] ──→ [ELEMENT] ──→ [SILNIK] ─α─→ [REDUKTOR] ─φ─→ [OBIEKT] ─T─→
    ↑                                ↑          NIELINIOWY                                    REGULACJI    │
    │                                │                                                                     │
    └────────────────────────────────┴──────────[WZMACNIACZ SPRZĘŻENIA ZWROTNEGO]←──────────────────────────┘
                                                              φ
```

### Schemat strukturalny

```
       ΔT        ┌───┐   α  ┌───┐   φ  ┌─────┐
T1 ─(+)─→ [k₁] ─(+)─→│1/r│→ │k₂│ ──→ │ k₃  │ ──→ │ k₀  │ ─T─→
    ↑            ↑   │-1 │  │ s │     │     │     │────│
    │            │   └───┘   └───┘     └─────┘     │T₀s+1│
    │            │                                 └─────┘
    │            │                      ┌─────┐         │
    └────────────┴──────────────────────│ ksz │←────────┘
                                        └─────┘
```

### Dane liczbowe

**Parametry układu:**

```
T1 = 1 [°C]
K₀ = 25 [°C/rad]
T₀ = 2.5 [s]
K1 = 25 [amperozwoje/1°C]
K2 = 2 [rad/s]
K3 = 0.1 (reduktor)
Ksz = 2.5 [amperozwoje/rad]
```

**Element nieliniowy - strefa martwa:**
```
Szerokość strefy martwej: [-0.18; 0.18]
```

**Funkcja ψ(w):**
```
        ┌───┐  1
ψ(w) =  │   │ ──
        │-1 │ -r
        └───┘
```

gdzie r oznacza strefę martwą (relay/deadband).

### Transmitancja obiektu regulacji

**Człon inercyjny I rzędu:**

```
        k₀
G(s) = ─────
       T₀s+1
```

**Równanie różniczkowe:**

```
T·(dy/dt) + y(t) = k·x(t)
```

gdzie:
- k - współczynnik wzmocnienia
- T - stała czasowa

**Transmitancja:**

```
       k
G(s) = ───
       Ts+1
```

**Przykład obwodu RC:**

```
      R
  ───┳┳┳───
  │       │
u₁(s)  C  u₂(s)
  │       │
  ─────────
```

**Transmitancja obwodu RC:**

```
       U₂(s)      1
G(s) = ────── = ──────
       U₁(s)   RCs+R
```

### Charakterystyka skokowa

**Wykres odpowiedzi skokowej G(s) = k/(1+s·T):**

```
y(t) │
     │     K=y(∞)/x(∞) = 1/1 = 1
   1 ├─────────────────────
     │    ╱
     │   ╱ y(t)
     │  ╱
     │ ╱
     │╱  x(t) (skok jednostkowy)
   0 ┼─────┬────────────────→ t
     0  T=5 sek
```

**Parametry:**
- K = 1
- T = 5 sek
- Styczna w punkcie t=0 przecina wartość ustaloną w t=T

### Implementacja w Xcos

**Schemat blokowy z SIGN:**

```
[T1] → [Σ] ─ΔT─→ [K1] → [Σ] → [SIGN] → [K2] → [1/s] ─α─→ [K3] ─φ─→ [K0/(1+s·T0)] ─T─→ [SCOPE]
  ↑              ↑       ↑                       ↑                                      │
  │              │       │                       │                                      │
  │              │       └───────────────────────┴──[Ksz]←────────────────────────────┘
  │              │
  └──────────────┘
```

**Parametry bloku Deadband:**
```
Set Deadband parameters:
- End of dead band: 0.18
- Start of dead band: -0.18
- zero crossing (0:no, 1:yes): 1
```

**Warunek początkowy:**
```
war.pocz. = 0  (dla integratora α)
```

**Czas obliczeń:**
```
t = 9 [s]
```

### Wyniki symulacji

**Wykres T(t) i ΔT(t):**
- T(t) - czerwona krzywa: oscylacje wokół wartości zadanej T1=1
- ΔT(t) - niebieska krzywa: oscylacje błędu regulacji wokół 0
- Maksimum T(t) około 1.6 przy t ≈ 2 s
- Minimum ΔT(t) około -0.6 przy t ≈ 1 s
- Oscylacje stopniowo maleją
- Wartość ustalona: T ≈ 1, ΔT ≈ 0
- Czas symulacji: t ∈ [0, 9] [s]

### Wersja 2 schematu

**Odwrócona kolejność bloków SIGN i integratora:**

Wyniki identyczne jak w wersji 1, pokazujące poprawność obu implementacji.

---

## Podsumowanie

Wykład 3 przedstawia:

1. **Równania różniczkowe II rzędu:**
   - Liniowe z wymuszeniem sinusoidalnym (3.01)
   - Nieliniowe z tłumieniem kwadratowym (3.02)
   - Liniowe jednorodne (3.03)
   - Liniowe z wymuszeniem stałym (3.04)

2. **Układy równań różniczkowych:**
   - Układy liniowe sprzężone (3.05)

3. **Równania nieliniowe:**
   - Równania z nieliniowościami algebraicznymi (3.06, 3.07)
   - Oscylator Van der Pola (3.08)

4. **Równania wyższych rzędów:**
   - Równanie IV rzędu (3.09)
   - Równania ze zmiennymi współczynnikami (3.11)

5. **Nieliniowe układy regulacji:**
   - Układy z przekaźnikiem dwupołożeniowym (4.01)
   - Układy z elementem z nasyceniem (4.02)
   - Układy regulacji temperatury ze strefą martwą (4.03)

6. **Narzędzia analizy:**
   - Wykresy czasowe
   - Portrety fazowe
   - Transmitancje operatorowe
   - Człony inercyjne

**Kluczowe techniki modelowania:**
- Przekształcanie równań do postaci normalnej (x'' = f(...))
- Budowa schematów blokowych w Xcos
- Wykorzystanie bloków nieliniowych (SIGN, SQRT, potęgowanie)
- Implementacja sprzężeń zwrotnych
- Analiza stability i oscylacji
