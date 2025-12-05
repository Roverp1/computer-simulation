# Wykład 4 - Modelowanie i symulacja komputerowa

**Temat:** 
- Drgania harmoniczne tłumione
- Regulacja poziomu cieczy w zbiorniku
- Silnik obcowzbudny prądu stałego (model nieliniowy)
- Transformata Laplace'a
- Układy RL, RC, RLC
- Silnik obcowzbudny prądu stałego

---

## Przykład 5.01 - Drgania harmoniczne tłumione

### Opis fizyczny układu

**System masa-sprężyna-tłumik:**

```
      k (sprężyna)
  ───∩∩∩∩∩∩───
  │           │
  │    [m]    │ ← Fop = β*v (siła oporu)
  │           │
────┴─────────┴────
xmin   0   x(t)  xmax
```

### Parametry układu

```
m - masa ciężarka [kg]
k - współczynnik sprężystości sprężyny [kg/s²]
β - współczynnik tłumienia [kg/s]
v = dx/dt - prędkość [m/s]
x0 - wstępne wychylenie [m]
```

### Założenia modelu

Rozpatrzymy jedynie przypadek gdy siła oporu (tłumienia) jest proporcjonalna do prędkości:

```
Fop = β * v
```

### Równanie ruchu (prawo Newtona)

**Równanie różniczkowe z tłumieniem:**

```
m * a = -β * v - k * x

m * (d²x/dt²) = -β * (dx/dt) - k * x
```

**Postać normalna:**

```
d²x/dt² = -(β/m) * (dx/dt) - (k/m) * x
```

### Parametry przykładowe

```
x0 = 0.5 [m]
k = 10 [kg/s²]
m = 1 [kg]
β = 1.2 [kg/s]
```

### Warunki początkowe

```
x(0) = x0 = 0.5 [m]
v(0) = x'(0) = 0 [m/s]
```

### Schemat blokowy Xcos

**Parametry w modelu:**
```
beta=1.2; m=1; K=10; a=0.5
```

**Struktura:**

```
[Σ] → [∫] → [∫] → [SCOPE]
 ↑     │x''  │x'   │x
 │     │     │     │
 ├[*(-beta/m)]←────┤
 │                 │
 └[*(-K/m)]←───────┘
                   └→[XY SCOPE]
```

**Warunki początkowe:**
- x'(0) = 0
- x(0) = x0

### Wyniki symulacji (β = 1.2)

**Wykres x(t):**
- Wartość początkowa: x(0) = 0.5
- Oscylacje tłumione
- Minimum około -0.25 przy t ≈ 1 s
- Dążenie do wartości ustalonej x = 0
- Czas symulacji: t ∈ [0, 7] [s]

**Portret fazowy (x' vs x):**
- Spirala zbieżna do punktu (0, 0)
- Punkt startowy: (0.5, 0)
- Ruch spiralny w kierunku środka

---

## Warunki tłumienia krytycznego

### Warunek matematyczny

```
ω₀² - (β/2m)² = 0

gdzie: ω₀ = √(k/m)
```

### Obliczenie β dla tłumienia krytycznego

```
dla k = 10 oraz m = 1:

β = 6.32 [kg/s]
```

### Wyniki dla β = 6.32 (tłumienie krytyczne)

**Wykres x(t):**
- Monotoniczny spadek z wartości x(0) = 0.5
- Brak oscylacji (przebieg aperiodyczny)
- Asymptotyczne dążenie do x = 0
- Najszybsze osiągnięcie stanu ustalonego bez oscylacji

**Portret fazowy:**
- Krzywa bez spiralności
- Bezpośrednie dążenie do punktu (0, 0)

---

## Warunki przetłumienia

### Warunek matematyczny

```
ω₀² - (β/2m)² < 0

gdzie: ω₀ = √(k/m)

dla k = 10 oraz m = 1: β > 6.32
```

### Wyniki dla β > 6.32 (przetłumienie)

**Wykres x(t):**
- Monotoniczny spadek z wartości x(0) = 0.5
- Brak oscylacji
- Wolniejsze osiągnięcie stanu ustalonego niż przy tłumieniu krytycznym
- Przebieg aperiodyczny

**Portret fazowy:**
- Krzywa bez spiralności
- Powolne dążenie do punktu (0, 0)

---

## Przykład 5.02 - Regulacja poziomu cieczy w zbiorniku

### Opis problemu

Rozważmy problem związany z regulowanym dopływem cieczy do zbiornika i jej swobodnym wypływem. Problem polega na takim regulowaniu dopływu aby przy zadanym wypływie osiągnąć i utrzymać stały poziom cieczy w zbiorniku.

### Schemat układu

```
    ╔═══════════╗
    ║ Opóźnienie║
Q1(t)║    T₀     ║
──╥──╩═══════════╝
  ║              ┌────────┐
  ║   h(t)       │ Pomiar │
  ║   ╔══════╗   │poziom │
  ║   ║ ro,S ║   └────────┘
  ║   ║      ║
  ║   ║      ║
  ║   ╚══════╝
  ║      │
  ║      │Q(t)
  ╚══════╧═════
```

### Parametry zbiornika

```
S - pole podstawy walca [m²]
ro (ρ) - gęstość cieczy [kg/m³]
h(t) - wysokość poziomu cieczy [m]
Q1(t) - szybkość dopływu [kg/s]
Q(t) - szybkość wypływu [kg/s]
T₀ - czas opóźnienia reakcji zaworu [s]
h₀ - wysokość początkowa cieczy [m]
```

### Równania układu

**Szybkość wypływu ze zbiornika:**
```
Q(t) = k * h(t)
```

**Szybkość dopływu do zbiornika przez zawór:**
```
Q1(t) = Q1m - k1 * h(t - T₀)
```

gdzie:
- k, k1 - odpowiednie współczynniki proporcjonalności
- T₀ - czas opóźnienia reakcji zaworu
- Q1m - szybkość dopływu w chwili początkowej (zawór w pełni otwarty) odpowiadająca pełnej wydajności

**Zasada działania zaworu:**
- Jeżeli h(t-T₀) rośnie to dopływ Q1(t) maleje
- Jeżeli h(t-T₀) maleje to dopływ Q1(t) rośnie

### Równanie równowagi mas

**W małym przedziale czasu dt:**

```
r0 * S * Δh = [Q1(t) - Q(t)] * Δt
```

W dostatecznie małym przedziale czasu dt wokół chwili czasowej t różnica mas dopływu i odpływu musi odpowiadać przyrostowi ro*S*dh masy cieczy w zbiorniku:

```
r0 * S * dh = [Q1(t) - Q(t)] * dt

r0 * S * (dh/dt) = Q1m - k1 * h(t - T₀) - k * h(t)
```

### Postać normalna równania

**Wyznaczając pochodną dh/dt:**

```
dh/dt = Q1m/(r0*S) - k1/(r0*S) * h(t - T₀) - k/(r0*S) * h(t)
```

**Postać uproszczona:**

```
dh/dt = Q*1m - k1* * h(t - T₀) - k* * h(t)
```

przy czym:
- Q*1m - wydajność dopływu wyrażona w [m/s]
- k1*, k* - współczynniki, które mają wymiar [1/s]

### Warunek początkowy

```
h(0) = h0
```

gdzie h0 to wstępne wypełnienie zbiornika.

### Implementacja w Xcos - blok opóźnienia

**Blok TIME_DELAY w modelu symulacyjnym:**

W modelu należy użyć bloku opóźnienia: TIME_DELAY

**Parametry bloku opóźnienia:**
- Parametr 1: wartość opóźnienia T₀
- Parametr 2: wartość początkowa
- Parametr 3: rozmiar bufora

**Rozmiar bufora:**

```
Rozmiar bufora = czas_symulacji / krok całkowania

np. Rozmiar bufora = 30 [s] / 0.01 [s] = 3000
```

### Schemat blokowy Xcos

**Oznaczenia w modelu:**
```
Q1mg = Q*1m
K1g = k1*
Kg = k*
h(0) = h0
```

**Struktura:**

```
[Q1mg] ──→ [Σ] → [∫] → h(t) → [SCOPE]
            ↑     │         │
            │     │         │
            ├[*(-Kg)]←──────┤
            │               │
            └[*(-K1g)]←[T₀]─┘
                    ↑
              [TIME_DELAY]
```

**Warunek początkowy:**
```
h(0) = h0
```

### Przykładowe wyniki symulacji

#### Scenariusz 1: Q1mg=0.25; Kg=0.8; K1g=0.5; T0=3; h0=0

**Charakterystyka:**
- Wzrost poziomu do maksimum około 0.3 przy t ≈ 4 s
- Po 3 [s] nalewania wody jest reakcja układu przymykania zaworu
- Oscylacje wokół poziomu ustalonego około 0.2
- Czas symulacji: t ∈ [0, 30] [s]

#### Scenariusz 2: Q1mg=0.25; Kg=0.5; K1g=0.5; T0=5; h0=0.4

**Charakterystyka:**
- Wartość początkowa h(0) = 0.4
- Silne oscylacje spowodowane większym opóźnieniem (T0=5)
- Maksimum około 0.5 przy t ≈ 10 s
- Tłumione oscylacje wokół poziomu ustalonego około 0.25
- Czas symulacji: t ∈ [0, 100] [s]

#### Scenariusz 3: Q1mg=0.25; Kg=0.5; K1g=0.1; T0=3; h0=0

**Charakterystyka:**
- Słabe regulowanie dopływu (mały K1g)
- Monotoniczny wzrost do wartości ustalonej około 0.42
- Brak oscylacji (mała wartość K1g)
- Czas symulacji: t ∈ [0, 30] [s]

#### Scenariusz 4: Q1mg=0.25; Kg=0.5; K1g=0.5; T0=3; h0=0

**Charakterystyka:**
- Maksimum około 0.4 przy t ≈ 4 s
- Tłumione oscylacje
- Wartość ustalona około 0.25
- Czas symulacji: t ∈ [0, 30] [s]

#### Scenariusze 5 i 6: Porównanie T0=3 vs T0=5 (h0=0.4)

**Dla T0=3:**
- Oscylacje umiarkowane
- Szybsza stabilizacja

**Dla T0=5:**
- Silniejsze oscylacje
- Wolniejsza stabilizacja
- Większe opóźnienie powoduje większą niestabilność

---

## Przykład 5.03 - Model nieliniowy silnika szeregowego prądu stałego

### Układ równań modelu

```
uz = R * i(t) + Z * (dΦ(t)/dt) + e(t)
e(t) = Ce * Φ(t) * ω(t)
m(t) = mobc + mdyn(t)
m(t) = Cm * Φ(t) * i(t)
mdyn(t) = J * (dω(t)/dt)
```

### Warunki początkowe

```
Φ(0) = Φ0 = 0
ω(0) = ω0 = 0
```

### Nieliniowa zależność strumienia od prądu

**Krzywa magnesowania silnika:**

```
Φ = f(i)
```

Jest to tzw. krzywa magnesowania silnika, dana w formie tabeli lub wykresu - nieliniowa zależność strumienia magnetycznego od prądu.

### Symbole literowe

**Wielkości wejściowe:**
- uz, mobc - napięcie zasilania i moment obciążenia silnika

**Wielkości wyjściowe:**
- i, ω - prąd i prędkość kątowa silnika

**Parametry:**
- R, Z, J, Ce, Cm - stałe silnika

**Wielkości wewnętrzne:**
- e - siła elektromotoryczna indukowana w tworniku
- m, mdyn - moment obrotowy i moment dynamiczny silnika
- Φ - strumień magnetyczny w silniku, powstały wskutek przepływu pobieranego przez silnik prądu i(t)

**Warunki początkowe:**
```
Φ0 = 0
ω0 = 0
```

Równania te prezentują model matematyczny rozważanego silnika, wynikający wprost z zasady jego działania.

### Przekształcenie do postaci normalnej

**Równania przekształcone:**

```
dΦ/dt = (1/Z)*uz - (R/Z)*i - (Ce/Z)*Φ*ω

dω/dt = (Cm/J)*Φ*i - (1/J)*mobc

i = f⁻¹(Φ)
```

**Krzywa magnesowania:**
```
Φ = f(i)
```

lub w postaci odwrotnej:
```
i = f⁻¹(Φ)
```

### Schemat blokowy silnika szeregowego

**Struktura:**

```
[uz] ──→ [Σ] → [∫] → Φ → [f⁻¹] → i
         ↑     │dΦ/dt      ↑
         │     │           │
    [*(R/Z)]←──┴───────────┘
         │
    [*(Ce/Z)]←[X]←[Φ*ω]
                   ↑
                   │
[mobc]→[Σ]→[∫]→ω──┘
        ↑   │dω/dt
        │   │
   [*(Cm/J)]←[X]←[Φ*i]
                  ↑
                  └───────────┘
```

**Bloki specjalne:**
- f⁻¹(Φ) - blok nieliniowy z krzywą odwrotną
- X - bloki mnożenia
- Π - bloki produktu

Z uwagi na krzywą magnesowania jest to model nieliniowy.

### Przykładowe dane

```
UZ = 110 [V]
Mobc = 300 [N*m]
R = 0.173 [Ω]
Z = 150
J = 5 [kg*m²]
ce = cm = 95.5
```

### Krzywa magnesowania silnika

**Tabela Φ = f(i):**

| Φ [Wb] | 0.000 | 0.005 | 0.010 | 0.015 | 0.020 | 0.025 | 0.030 | 0.035 | 0.040 | 0.045 |
|--------|-------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| i [A]  | -5    | 7     | 20    | 35    | 50    | 75    | 119   | 200   | 350   | 640   |

**Charakterystyka graficzna:**
- Oś X: i [A], zakres [0, 800]
- Oś Y: Φ [Wb], zakres [0, 0.05]
- Krzywa nieliniowa, typowa dla zjawisk magnetyzacji
- Strefa nasycenia dla dużych prądów

### Implementacja w Xcos

**Parametry symulacji:**
```
Czas obliczeń: 1 [s]
Krok obliczeniowy: h = 0.001 [s]
```

**Warunki początkowe:**
```
Φ(0) = 0
ω(0) = 0
```

**Blok interpolacji (Set Interpolation block parameters):**
```
X coord.: [0.000; 0.005; 0.045]
Y coord.: [-5, 7, 20, 35, 50, 80, 119, 200, 350, 640]
```

### Wyniki symulacji

**Wykres i(t):**
- Maksimum około 500 A przy t ≈ 0.05 s
- Szybki spadek do wartości ustalonej około 150 A
- Czas przejściowy około 0.3 s

**Wykres Φ(t):**
- Wzrost z 0 do wartości maksymalnej około 0.045 Wb
- Stabilizacja na poziomie około 0.03 Wb

**Wykres ω(t):**
- Wzrost z 0 do wartości ustalonej około 32-33 [rad/s]
- Przebieg monotoniczny
- Czas przejściowy około 0.5-0.6 s

**Ustawienia monitora (Set Scope parameters):**
```
Input ports sizes: 1 1 1
Drawing colors (>0) or mark (<0): 1 5 9 7 3 11 13 15
Output window number (-1 for automatic): -1
Ymin vector: -10 0 -5
Ymax vector: 500 0.045 35
Refresh period: 1 1 1
```

### Wersja 2 - z wykorzystaniem bloku Expression

**Bloki Expression:**

**Expression 1 (dla dΦ/dt):**
```
(Uz - R*u1 - Ce*u3*u2)/Z
```
gdzie:
- u1 = i
- u2 = ω
- u3 = Φ

**Expression 2 (dla dω/dt):**
```
(Cm*u1*u2 - Mobc)/J
```
gdzie:
- u1 = Φ
- u2 = i

---

## Transformata Laplace'a - Układy RL, RC, RLC

### Wprowadzenie do transformaty Laplace'a

**W wyniku przekształcenia (transformaty) Laplace'a następuje:**
- Przekształcenie równania różniczkowego zwyczajnego w równanie algebraiczne, którego zmienną jest operator Laplace'a s
- Ostateczne rozwiązanie równania różniczkowego jako funkcji czasu rzeczywistego jest operacją wyznaczania funkcji f(t) z danej funkcji F(s) będącej rozwiązaniem równania algebraicznego [tzw. oryginał funkcji F(s)]
- Wykonuje się przy użyciu odwrotnej transformaty Laplace'a

**Właściwości:**
- Transformata Laplace'a jest przekształceniem jednowartościowym, tzn. danej funkcji ciągłej f(t) odpowiada tylko jedna transformata F(s)
- Transformaty Laplace'a F(s) podstawowych funkcji czasu rzeczywistego f(t) czyli przekształcenie f(t) → F(s) oraz transformaty odwrotne, tzn. przekształcenie F(s) → f(t) można znaleźć w licznych publikacjach w Internecie

---

## Przykład 6.01 - Układ RL

### Schemat obwodu

```
    L       R
o───∩∩∩∩───┳┳┳───o
│                 │
e(t)           i(t)
│                 │
o─────────────────o
```

### Równanie różniczkowe

```
L * (di(t)/dt) + R * i(t) = e(t) = k * 1(t)
```

gdzie:
```
1(t) = { 0  dla t < 0
       { 1  dla t ≥ 0
```
jest jednostkową funkcją skokową.

### Transformata Laplace'a równania

```
L * I(s) * s + R * I(s) = k * 1(s)

I(s) * (L*s + R) = k * 1(s)
```

### Transmitancja układu RL

**Definicja transmitancji:**

```
G(s) = I(s)/1(s) = k/(L*s + R)
```

lub

```
G(s) = I(s)/1(s) = (k/R)/((L/R)*s + 1)
```

**Dla k=1:**

```
G(s) = I(s)/1(s) = (1/R)/((L/R)*s + 1)
```

### Rozwiązanie operatorowe

Jeżeli warunki początkowe są zerowe, to korzystając z transmitancji G(s) i faktu, że e(t)=k*1(t) nasze rozwiązanie można przedstawić jako:

```
I(s) = G(s) * 1(s) = (k/R)/((L/R)*s + 1) * 1(s)
```

Ta postać naszego rozwiązania dla zmiennej s jest podstawą do wykonania modelu symulacyjnego.

### Modele symulacyjne w Xcos

#### Model 1 - Postać czasowa

**Równanie:**
```
di/dt = (1/L) * (k*1(t) - R*i(t))
i(0) = 0
```

**Schemat:**
```
[1] → [K] → [Σ] → [1/L] → [∫] → i(t) → [SCOPE]
              ↑              │i(0)=0
              │              │
              └──[*(-R)]←────┘
```

#### Model 2 - Postać operatorowa

**Transmitancja:**
```
G(s) = (K/R)/(1 + s*L/R)
```

**Schemat:**
```
[1] → [G(s)] → I(s) → [SCOPE]
```

**Parametry przykładowe:**
```
K=5; L=6; R=2
```

### Wyniki symulacji

**Charakterystyka i(t):**
- Wartość początkowa: i(0) = 0
- Wykładniczy wzrost do wartości ustalonej
- Wartość ustalona: iust = K/R = 5/2 = 2.5 A
- Stała czasowa: τ = L/R = 6/2 = 3 s
- Czas symulacji: t ∈ [0, 10] [s]

Oba modele dają identyczne wyniki.

---

## Przykład 6.02 - Układ RC

### Schemat obwodu

```
      R
  ───┳┳┳───┬───
  │         │
e(t)      ──┴── C
  │       ──┬──
  │         │
  ────────────
         uC(t)
```

### Równania obwodu

```
R * iC(t) + uC(t) = e(t) = k * 1(t)

ale: iC(t) = C * (duC(t)/dt)

więc: RC * (duC(t)/dt) + uC(t) = k * 1(t)
```

### Transformata Laplace'a

```
RC * UC(s) * s + UC(s) = k * 1(s)

UC(s) * (RC*s + 1) = k * 1(s)
```

### Transmitancja układu RC

```
G(s) = UC(s)/1(s) = k/(RC*s + 1)
```

### Rozwiązanie operatorowe

```
UC(s) = G(s) * 1(s) = k/(RC*s + 1) * 1(s)
```

Ta postać naszego rozwiązania dla zmiennej s jest podstawą do wykonania modelu symulacyjnego.

### Modele symulacyjne w Xcos

#### Model 1 - Postać czasowa

**Równanie:**
```
duC(t)/dt = (1/RC) * (k*1(t) - uC(t))
uC(0) = 0
```

**Schemat:**
```
[1] → [K] → [Σ] → [1/(R*C)] → [∫] → uC(t) → [SCOPE]
              ↑                 │Uc(0)=0
              │                 │
              └──[*(-1)]←───────┘
```

#### Model 2 - Postać operatorowa

**Transmitancja:**
```
G(s) = K/(1 + s*R*C)
```

**Schemat:**
```
[1] → [G(s)] → UC(s) → [SCOPE]
```

### Wyniki symulacji

**Charakterystyka uC(t):**
- Wartość początkowa: uC(0) = 0
- Wykładniczy wzrost do wartości ustalonej
- Wartość ustalona: uCust = K
- Stała czasowa: τ = RC
- Czas symulacji: t ∈ [0, 10] [s]

Oba modele dają identyczne wyniki.

---

## Przykład 6.03 - Układ RLC

### Schemat obwodu

```
    L       R
o───∩∩∩∩───┳┳┳───┬───o
│                 │
e(t)            ──┴── C
│               ──┬──
│                 │
o─────────────────o
              uC(t)
```

### Równanie obwodu

```
R * i(t) + L * (di(t)/dt) + uC(t) = e(t)

gdzie: i(t) = C * (duC(t)/dt)
```

### Wyznaczenie równania dla uC

Po wyznaczeniu pochodnej prądu otrzymujemy:

```
LC * (d²uC(t)/dt²) + RC * (duC/dt) + uC(t) = k * 1(t)
```

### Transformata Laplace'a

```
LC * UC(s) * s² + RC * UC(s) * s + UC(s) = k * 1(s)

UC(s) * (LC*s² + RC*s + 1) = k * 1(s)
```

### Transmitancja układu RLC

```
G(s) = UC(s)/1(s) = k/(LC*s² + RC*s + 1)
```

### Rozwiązanie operatorowe

```
UC(s) = G(s) * 1(s) = k/(LC*s² + RC*s + 1) * 1(s)
```

Ta postać naszego rozwiązania dla zmiennej s jest podstawą do wykonania modelu symulacyjnego.

### Modele symulacyjne w Xcos

#### Model 1 - Postać czasowa

**Równanie:**
```
d²uC(t)/dt² = (1/LC) * (k*1(t) - RC*(duC/dt) - uC(t))

uC(0) = 0
u'C(0) = 0
```

**Schemat:**
```
[1] → [K] → [Σ] → [1/(L*C)] → [∫] → [*C] → [∫] → uC(t) → [SCOPE]
              ↑                  │U'c(0)=0  │Uc(0)=0
              │                  │          │
              ├──[*(-R*C)]←──────┤          │
              │                             │
              └──[*(-1)]←─────────────────────┘
```

**Parametry przykładowe:**
```
K=1; R=1; L=1; C=1;
```

#### Model 2 - Postać operatorowa z różniczkowaniem

**Transmitancja:**
```
G(s) = K/(1 + R*C*s + L*C*s²)
```

**Schemat:**
```
[1] → [G(s)] → UC → [du/dt] → [*C] → i(t) → [SCOPE]
                │
                └───────────────────────→ [SCOPE]
```

**Blok różniczkujący:**
- Pozwala wyznaczyć prąd: i(t) = C * (duC(t)/dt)

### Wyniki symulacji

**Wykres uC(t):**
- Wartość początkowa: uC(0) = 0
- Oscylacje tłumione (dla układu niedotłumionego)
- Wartość ustalona: uCust = K
- Maksimum w pierwszej oscylacji

**Wykres i(t):**
- Wartość początkowa: i(0) = 0
- Maksimum w początkowej fazie ładowania
- Oscylacje tłumione
- Wartość ustalona: i = 0

Charakter odpowiedzi zależy od parametrów R, L, C.

---

## Przykład 6.04 - Modelowanie obcowzbudnego silnika elektrycznego prądu stałego

### Schemat silnika

```
      i
   o──→───────┐
   │          │
   │    ┌─────┴─────┐
uZ │    │     e     │ mobc
   │    │  ┌───┐ ω  │  ↓
   │    │  │ ⚙ │←───┤  m
   │    │  └───┘    │
   │    └───────────┘
   │          │
   o──────────┘
```

### Układ równań modelu

**Sposób działania obcowzbudnego silnika prądu stałego opisuje prosty układ liniowych równań różniczkowych i algebraicznych:**

```
uz(t) = R*i(t) + L*(di(t)/dt) + e(t)
e(t) = ke*ω(t)
m(t) = mobc(t) + mdyn(t)
m(t) = km*i(t)
mdyn(t) = J*(dω(t)/dt)
```

### Warunki początkowe

```
i(t=0) = i0 = 0
ω(t=0) = ω0 = 0
```

### Symbole literowe

**Wielkości wejściowe:**
- uz, mobc - napięcie zasilania i moment obciążenia silnika

**Wielkości wyjściowe:**
- i, ω - prąd i prędkość kątowa silnika

**Parametry:**
- R, L, J, ke, km - stałe silnika

**Wielkości wewnętrzne:**
- e - siła elektromotoryczna indukowana w tworniku
- m, mdyn - moment obrotowy i moment dynamiczny silnika

**Warunki początkowe:**
```
i0 = 0
ω0 = 0
```

Równania te prezentują model matematyczny rozważanego silnika, wynikający wprost z zasady jego działania.

### Równania stanu

**Wstawiając równanie drugie do pierwszego i wyznaczając pochodną prądu:**

```
di(t)/dt = (1/L)*uz - (ke/L)*ω(t) - (R/L)*i(t)
```

**Analogicznie wykorzystując trzy kolejne równania, wyznaczamy pochodną prędkości kątowej:**

```
dω(t)/dt = (km/J)*i(t) - (1/J)*mobc
```

### Przykładowe dane znamionowe

```
PN = 22 [kW]
UN = 440 [V]
IN = 56.2 [A]
ωN = 1500 [obr/min]
J = 2.7 [kg*m²]
R = 0.465 [Ω]
L = 0.015345 [H]
ke = 2.62 [V*s]
km = 2.62 [N*m/A]
```

**Warunki początkowe:**
```
i0 = 0
ω0 = 0
```

**Zmienne dane do obliczeń:**
```
uz = ???
mobc = ???
```

Pozostałe dane zgodne z danymi znamionowymi silnika.

### Model jako obiekt sterowania

**Blok OBIEKT:**

```
Wymuszenia (wejścia):     Odpowiedzi (wyjścia):
  uz(t)    ──→┐           ┌──→  i(t)
             │ OBIEKT │
  mobc(t)  ──→┘           └──→  ω(t)
```

uz(t) i mobc(t) to wymuszenia, a i(t) oraz ω(t) to sygnały wyjściowe.

### Równania w przestrzeni stanu

**Postać macierzowa:**

```
┌ di/dt ┐   ┌ -R/L   -ke/L ┐   ┌ i ┐   ┌ 1/L   0   ┐   ┌ uz   ┐
│       │ = │              │ · │   │ + │           │ · │      │
└ dω/dt ┘   └  km/J    0   ┘   └ ω ┘   └  0   -1/J ┘   └ mobc ┘
```

**Wzorzec:**
```
ẋ = Ax + Bu
```

Można więc łatwo określić macierze A i B, a prąd i(t) oraz prędkość kątową ω(t) silnika nazwać zmiennymi stanu (tworzą wektor x).

### Model operatorowy (transformata Laplace'a)

**Zakładając zerowe warunki początkowe:**

```
s*I(s) = (1/L)*Uz(s) - (R/L)*I(s) - (ke/L)*Ω(s)

s*Ω(s) = (km/J)*I(s) - (1/J)*Mobc(s)
```

### Transmitancje układu

**Rozwiązując układ równań operatorowych, wprowadzamy stałe czasowe:**

```
Te = L/R
Tem = J*R/(ke*km)
```

**Otrzymujemy cztery transmitancje:**

```
G1(s) = (J/(ke*km))·s / (s²·Tem·Te + s·Tem + 1)

G2(s) = (1/km) / (s²·Tem·Te + s·Tem + 1)

G3(s) = (1/ke) / (s²·Tem·Te + s·Tem + 1)

G4(s) = (R/(ke*km))·(s·Te + 1) / (s²·Tem·Te + s·Tem + 1)
```

### Model transmitancyjny

**Postać równań:**

```
I(s) = Uz(s)·G1(s) + Mobc(s)·G2(s)
Ω(s) = Uz(s)·G3(s) - Mobc(s)·G4(s)
```

lub w formie macierzowej:

```
┌ I(s) ┐   ┌ G1(s)   G2(s) ┐   ┌ Uz(s)   ┐
│      │ = │                │ · │         │
└ Ω(s) ┘   └ G3(s)  -G4(s) ┘   └ Mobc(s) ┘
```

### Definicje transmitancji

```
dla Mobc = 0:  G1(s) = I(s)/Uz(s),    G3(s) = Ω(s)/Uz(s)

dla Uz = 0:    G2(s) = I(s)/Mobc(s),  G4(s) = Ω(s)/Mobc(s)
```

### Schemat blokowy transmitancyjny

```
Uz(s) ──┬──→ [G1] ──┬──→ [Σ] ──→ I(s)
        │           │     ↑
        └──→ [G3] ──│──┐  │
                    │  │  │
Mobc(s)─┬──→ [G2] ──┘  │  │
        │              │  │
        └──→ [G4] ──→ [Σ]─┴──→ Ω(s)
                      -
```

Na zaprezentowanym schemacie blokowym, zgodnie z ideą pojęcia transmitancji, szczególnie wyraźnie widać matematyczne zależności pomiędzy sygnałami wyjściowymi a wejściowymi.

Musimy jednak pamiętać, że uzyskanie realnych przebiegów (czyli w funkcji czasu) wymaga odwrotnego przekształcenia Laplace'a, w celu przejścia z form operatorowych do funkcji czasu.

### Implementacja w Xcos - wartości liczbowe

**Dla danych przykładowych:**
```
R = 0.465; L = 0.015; J = 2.7;
Km = 2.62; Ke = 2.62;
```

**Transmitancje numeryczne:**

```
G1(s) = (66.67*s) / (s² + 31*s + 169.49)

G2(s) = 64.69 / (s² + 31*s + 169.49)

G3(s) = 64.69 / (s² + 31*s + 169.49)

G4(s) = (0.37*s + 11.48) / (s² + 31*s + 169.49)
```

### Wyniki symulacji

#### Scenariusz 1: Uz=100, Mobc=0

**ω(t):**
- Monotoniczny wzrost do wartości ustalonej około 25 [rad/s]
- Czas przejściowy około 0.6 s

**i(t):**
- Skok początkowy do około 170 A
- Szybki spadek do wartości ustalonej bliskiej 0
- Czas przejściowy około 0.4 s

#### Scenariusz 2: Uz=100, Mobc=100

**ω(t):**
- Monotoniczny wzrost do wartości ustalonej około 31 [rad/s]
- Czas przejściowy około 0.6 s

**i(t):**
- Skok początkowy do około 170 A
- Spadek do wartości ustalonej około 40 A
- Czas przejściowy około 0.6 s

#### Scenariusz 3: Uz=100, Mobc=200

**ω(t):**
- Monotoniczny wzrost do wartości ustalonej około 25 [rad/s]
- Wolniejszy rozruch niż w poprzednich scenariuszach
- Czas przejściowy około 0.8 s

**i(t):**
- Skok początkowy do około 190 A
- Spadek do wartości ustalonej około 80 A
- Czas przejściowy około 0.8 s

---

## Podsumowanie

Wykład 4 przedstawia:

1. **Drgania harmoniczne tłumione:**
   - Model masa-sprężyna-tłumik
   - Rodzaje tłumienia (niedotłumienie, tłumienie krytyczne, przetłumienie)
   - Portrety fazowe

2. **Regulacja poziomu cieczy:**
   - Układ z opóźnieniem
   - Blok TIME_DELAY w Xcos
   - Wpływ parametrów na stabilność

3. **Silnik szeregowy prądu stałego:**
   - Model nieliniowy z krzywą magnesowania
   - Implementacja z blokiem interpolacji

4. **Transformata Laplace'a:**
   - Podstawy teoretyczne
   - Transformaty jednostkowej funkcji skokowej
   - Transmitancje operatorowe

5. **Układy elektryczne RL, RC, RLC:**
   - Modele czasowe i operatorowe
   - Implementacja w Xcos (dwie wersje)
   - Porównanie wyników

6. **Silnik obcowzbudny prądu stałego:**
   - Model liniowy
   - Równania stanu
   - Model operatorowy z transmitancjami
   - Schemat blokowy transmitancyjny
   - Symulacje dla różnych obciążeń

**Kluczowe techniki:**
- Przekształcenia Laplace'a
- Transmitancje operatorowe
- Modele w przestrzeni stanu
- Bloki continuous time w Xcos
- Bloki TIME_DELAY i różniczkujące
