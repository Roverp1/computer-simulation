# Laboratorium 2 - Modele symulacyjne

## Cel zajęć

Korzystając z materiałów zamieszczonych w wykładach opracować i uruchomić procesy opisane równaniami różiczkowymi dla stanów nieustalonych (przejściowych) w układach.

---

## Zadanie 1 - Modelowanie oscylatora harmonicznego tłumionego bez tarcia

### Schemat układu fizycznego

```
┌──────────────────────────────────────────────────┐
│      ──────→ x                                   │
│      │                                           │
│  ┌───┴────┐         cẋ (siła tłumienia)         │
│  │   c    │    ←─── kx (siła sprężyny)          │
│  ├───┬────┤                                      │
│      │                                           │
│      m (masa)                                    │
│      │                                           │
│  ///││///  (podpora)                             │
│      │                                           │
│      k (sprężyna)                                │
└──────────────────────────────────────────────────┘
```

**Opis układu:**
- Masa **m** połączona z nieruchomą podporą przez:
  - **Sprężynę** o współczynniku sprężystości **k**
  - **Tłumik** o współczynniku tłumienia **c**
- **Bez tarcia** (brak tarcia suchego/Coulomba)
- Układ uwolniony od więzów (diagram sił)

### Równanie ruchu

**Równanie na podstawie II zasady dynamiki Newtona:**
```
m * (d²x/dt²) + c * (dx/dt) + kx = 0
```

**Warunki początkowe:**
```
x(0) = a
dx/dt|t=0 = 0  (brak prędkości początkowej)
```

### Przekształcenie równania

**Po wyciągnięciu 1/m przed nawias:**
```
d²x/dt² = (1/m) * (-c * (dx/dt) - kx)
```

**Warunki początkowe:**
```
x(0) = a
x'(0) = 0
```

### Dane do obliczeń

```
m = 0.5  [kg]
c = 0.2  [N·s/m]
k = 5    [N/m]
a = 0.5  [m]
```

**Parametry symulacji:**
- Krok obliczeniowy: **h = 0.01 [s]**
- Czas obliczeń: **Tkon = 16 [s]**

### Analiza teoretyczna

**Częstość drgań własnych (nietłumionych):**
```
ω₀ = √(k/m) = √(5/0.5) = √10 ≈ 3.162 rad/s
```

**Współczynnik tłumienia:**
```
ζ = c / (2√(mk)) = 0.2 / (2√(0.5*5)) = 0.2 / (2√2.5) ≈ 0.063
```

**Częstość drgań tłumionych:**
```
ωd = ω₀√(1 - ζ²) ≈ ω₀ * 0.998 ≈ 3.156 rad/s
```

**Okres drgań tłumionych:**
```
T = 2π/ωd ≈ 1.99 s
```

**Stała czasowa zaniku (decay):**
```
τ = 2m/c = 2*0.5/0.2 = 5 s
```

**Interpretacja:**
- **ζ < 1** → układ **podkrytycznie tłumiony** (underdamped)
- Oscylacje z **zanikającą amplitudą**
- Amplituda maleje wykładniczo: A(t) = a * e^(-t/τ)
- Po czasie ~5τ = 25s amplituda praktycznie zanika do zera

### Implementacja w Xcos

**Model zgodny z wykładem 2.01 (zadanie 2.01):**

```
┌──────────────────────────────────────────────────────────┐
│           x'(0) = 0       x(0) = a                       │
│               ↓               ↓                          │
│  [Σ] → [1/m] → x''(t) → [∫] → x'(t) → [∫] → x(t) → [Mon]│
│   ↑                        ↓                             │
│   |←──────[c]←─────────────┘                            │
│   |                                                      │
│   |←──────[K]←──────────────────────────┘               │
│                                                          │
│  m=0.5; c=0.2; k=5; a=0.5                               │
└──────────────────────────────────────────────────────────┘
```

**Szczegółowy opis przepływu sygnałów:**

1. **[Σ]** - sumator z trzema wejściami:
   - Wejście 1 (-): -c * x'(t) (sprzężenie zwrotne od pierwszego integratora)
   - Wejście 2 (-): -k * x(t) (sprzężenie zwrotne od drugiego integratora)
   - Wyjście: -c * x'(t) - k * x(t)

2. **[1/m]** - wzmacniacz o wzmocnieniu 1/m = 1/0.5 = 2
   - Wyjście: x''(t) = (1/m) * (-c * x'(t) - k * x(t))

3. **[∫]** - pierwszy integrator z warunkiem początkowym x'(0) = 0
   - Wyjście: x'(t) (prędkość)

4. **[c]** - wzmacniacz o wzmocnieniu c = 0.2
   - Wejście: x'(t)
   - Wyjście: c * x'(t) (feedback do sumatora)

5. **[∫]** - drugi integrator z warunkiem początkowym x(0) = a = 0.5
   - Wyjście: x(t) (położenie)

6. **[K]** - wzmacniacz o wzmocnieniu k = 5
   - Wejście: x(t)
   - Wyjście: k * x(t) (feedback do sumatora)

7. **[Monitor]** - wyświetlacz wykresu x(t)

### Konfiguracja w Xcos

**Ustaw kontekst (Widok → Ustaw kontekst):**
```scilab
m=0.5; c=0.2; k=5; a=0.5
```

**Parametry symulacji:**
- Ostateczny czas integracji: `16`

**Parametry bloku CLOCK_c:**
- Okres: `0.01` [s]
- Initialisation Time: `0`

**Parametry pierwszego integratora:**
- Initial Condition: `0` (dla x'(0))

**Parametry drugiego integratora:**
- Initial Condition: `a` (dla x(0))

**Parametry monitora:**
- Ymin: `-0.6`
- Ymax: `0.6`
- Refresh period: `16`

**Parametry sumatora:**
- Number of inputs: `[1; -1; -1]` lub `2` (dla dwóch wejść ze znakiem minus)
- Inputs ports signs/gain: `[-1; -1]` (oba wejścia ze znakiem minus)

### Oczekiwany wykres

**Charakterystyka x(t):**
```
x(t) [m]
 0.5 ┤   ╱╲                              
     │  ╱  ╲        ╱╲                   
 0.3 ┤ ╱    ╲      ╱  ╲      ╱╲          
     │╱      ╲    ╱    ╲    ╱  ╲         
 0.1 ┼────────╲──╱──────╲──╱────╲────────
     │        ╲╱        ╲╱      ╲╱       
-0.1 ┤                                    
     │                                    
-0.3 ┤                                    
     │                                    
-0.5 └──┴────┴────┴────┴────┴────┴────┴──→ t[s]
     0  2    4    6    8   10   12   14  16
```

**Cechy wykresu:**
- **Oscylacje sinusoidalne** z zanikającą amplitudą
- **Amplituda początkowa:** 0.5 m
- **Okres drgań:** ~2 s
- **Zanik amplitudy:** wykładniczy, stała czasowa τ ≈ 5 s
- **Po ~15-16 s:** amplituda praktycznie zanika
- **Symetryczne oscylacje** wokół zera

### Zadania do wykonania

1. **Zbuduj model** w Xcos zgodnie z wykładem 2.01
2. **Uruchom symulację** i zaobserwuj:
   - Czy oscylacje są symetryczne?
   - Czy amplituda maleje wykładniczo?
   - Czy okres drgań wynosi ~2 s?
3. **Zmierz z wykresu:**
   - Okres drgań T (czas między kolejnymi maksimami)
   - Amplitudy kolejnych maksimów: A₁, A₂, A₃...
4. **Oblicz logarytmiczny dekrement tłumienia:**
   ```
   δ = ln(A₁/A₂) = (2πζ)/√(1-ζ²)
   ```
5. **Porównaj** z wartością teoretyczną
6. **Zapisz model** jako `lab2_oscylator_tlumiony.zcos`
7. **Eksportuj wykres** do dokumentacji

### Wskazówki

- **Sprawdź znaki w sumatorze** - oba wejścia powinny być ze znakiem minus
- **Upewnij się** że warunki początkowe są prawidłowo ustawione
- **Jeśli wykres nie mieści się** w oknie monitora, użyj ikony LUPKI do dopasowania
- **Okres można zmierzyć** klikając na wykresie w dwóch kolejnych maksimach

### Eksperyment dodatkowy (opcjonalnie)

**Zbadaj wpływ współczynnika tłumienia c:**

| c [N·s/m] | ζ | Typ tłumienia | Oczekiwany efekt |
|-----------|---|---------------|------------------|
| 0.1 | 0.032 | Podkrytyczne | Wolniejszy zanik |
| 0.2 | 0.063 | Podkrytyczne | Standardowy zanik |
| 0.5 | 0.158 | Podkrytyczne | Szybszy zanik |
| 1.0 | 0.316 | Podkrytyczne | Bardzo szybki zanik |
| 3.162 | 1.0 | Krytyczne | Brak oscylacji, najszybszy powrót |
| 5.0 | 1.58 | Nadkrytyczne | Wolny powrót bez oscylacji |

---

## Zadanie 2 - Modelowanie obcowzbudnego silnika elektrycznego prądu stałego

### Schemat układu silnika

```
        i
    o───┬───o
        │
       uz   
        │   ┌─────────────┐
      L─┴─R │   Motor     │  mobc
        │   │   ω ↻  e    │  ←─
    o───┴───┴─────────────┴───o
```

**Elementy układu:**
- **uz** - napięcie zasilania [V]
- **R** - rezystancja obwodu twornika [Ω]
- **L** - indukcyjność obwodu twornika [H]
- **i** - prąd twornika [A]
- **e** - siła elektromotoryczna (SEM) indukowana [V]
- **ω** - prędkość kątowa wirnika [rad/s]
- **mobc** - moment obciążenia [N·m]

### System równań

**Równania opisujące silnik:**

1. **Równanie obwodu elektrycznego (obwód twornika):**
   ```
   uz = R * i(t) + L * (di(t)/dt) + e(t)
   ```

2. **Siła elektromotoryczna (back-EMF):**
   ```
   e(t) = ke * ω(t)
   ```

3. **Bilans momentów:**
   ```
   m(t) = mobc + mdyn(t)
   ```

4. **Moment elektromagnetyczny:**
   ```
   m(t) = km * i(t)
   ```

5. **Moment dynamiczny (moment bezwładności):**
   ```
   mdyn(t) = J * (dω(t)/dt)
   ```

**Symbole literowe:**
- **uz, mobc** - napięcie zasilania i moment obciążenia silnika
- **i, ω** - prąd i prędkość kątowa silnika
- **R, L, J, ke, km** - stałe silnika
- **e** - siła elektromotoryczna indukowana w tworniku
- **m, mdyn** - moment obrotowy i moment dynamiczny silnika

**Warunki początkowe:**
```
i(0) = i₀ = 0
ω(0) = ω₀ = 0
```

### Przekształcenie równań

**Równanie dla prądu (wstawiając równanie 2 do 1):**
```
uz = R * i(t) + L * (di(t)/dt) + ke * ω(t)

di(t)/dt = (1/L) * uz - (ke/L) * ω(t) - (R/L) * i(t)
```

**Równanie dla prędkości kątowej (z równań 3, 4, 5):**
```
km * i(t) = mobc + J * (dω(t)/dt)

dω(t)/dt = (km/J) * i(t) - (1/J) * mobc
```

**System dwóch równań różniczkowych wzajemnie zależnych:**
```
di/dt = (1/L)(uz - ke * ω - R * i)

dω/dt = (1/J)(km * i - mobc)
```

**Warunki początkowe:**
```
i₀ = 0
ω₀ = 0
```

### Dane do obliczeń

**Dane znamionowe silnika:**
```
J = 2.7        [kg·m²]    - moment bezwładności
R = 0.465      [Ω]        - rezystancja twornika
L = 0.015345   [H]        - indukcyjność twornika
ke = 2.62      [V·s]      - stała SEM
km = 2.62      [N·m/A]    - stała momentu
```

**Parametry symulacji:**
- Krok obliczeniowy: **h = 0.001 [s]**
- Czas obliczeń: **Tkon = 1.5 [s]**

### Warianty obliczeń

**Wykonać 3 symulacje:**

| Wariant | uz [V] | mobc [N·m] | Opis |
|---------|--------|------------|------|
| 1 | 100 | 200 | Niska prędkość, wysokie obciążenie |
| 2 | 200 | 200 | Wysoka prędkość, wysokie obciążenie |
| 3 | 200 | 50 | Wysoka prędkość, niskie obciążenie |

### Analiza teoretyczna

**Prąd ustalony:**
```
W stanie ustalonym: di/dt = 0, dω/dt = 0

Z równania momentu: km * i = mobc
i(∞) = mobc / km

Dla mobc = 200 Nm: i(∞) = 200/2.62 ≈ 76.3 A
Dla mobc = 50 Nm:  i(∞) = 50/2.62 ≈ 19.1 A
```

**Prędkość ustalona:**
```
Z równania napięcia: uz = R * i + ke * ω
ω(∞) = (uz - R * i) / ke

Wariant 1: ω(∞) = (100 - 0.465*76.3) / 2.62 ≈ 24.7 rad/s
Wariant 2: ω(∞) = (200 - 0.465*76.3) / 2.62 ≈ 62.9 rad/s
Wariant 3: ω(∞) = (200 - 0.465*19.1) / 2.62 ≈ 73.0 rad/s
```

**Prąd początkowy (przy ω = 0):**
```
di/dt|t=0 = uz/L

Dla uz = 100V: di/dt = 100/0.015345 ≈ 6517 A/s
Dla uz = 200V: di/dt = 200/0.015345 ≈ 13034 A/s
```

### Implementacja w Xcos

**Model zgodny z wykładem 1.05:**

```
┌──────────────────────────────────────────────────────────────┐
│                    Model silnika                             │
│                                                              │
│  Obwód elektryczny (równanie dla i):                        │
│                         i(0) = 0                            │
│                             ↓                                │
│  [Uz] → [Σ] → [1/L] → i'(t) → [∫] → i(t) → [Monitor]       │
│         - ↑                           │                      │
│           |←──────[R]←────────────────┘                     │
│           |                                                  │
│           |←──────[Ke]←─────────────┐                       │
│                                      │                       │
│  Obwód mechaniczny (równanie dla ω): │                       │
│                         ω(0) = 0     │                       │
│                             ↓        │                       │
│  [Mobc] → [Σ] → [1/J] → ω'(t) → [∫] → ω(t) → [Monitor]     │
│          + ↑                                                 │
│            |←──────[Km]←────────────[i(t) z góry]           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Szczegółowy opis przepływu sygnałów:**

**Obwód elektryczny (prąd i):**
1. **[Uz]** - stała napięcia zasilania
2. **[Σ]** - sumator (3 wejścia):
   - Wejście 1 (+): uz
   - Wejście 2 (-): R * i(t) (feedback)
   - Wejście 3 (-): ke * ω(t) (sprzężenie z obwodem mechanicznym)
   - Wyjście: uz - R*i - ke*ω
3. **[1/L]** - wzmacniacz 1/L
4. **[∫]** - integrator z i(0) = 0
5. **[R]** - wzmacniacz R (feedback)
6. **[Ke]** - wzmacniacz ke (sprzężenie od ω)

**Obwód mechaniczny (prędkość ω):**
1. **[Σ]** - sumator (2 wejścia):
   - Wejście 1 (+): km * i(t) (sprzężenie z obwodu elektrycznego)
   - Wejście 2 (-): mobc
   - Wyjście: km*i - mobc
2. **[1/J]** - wzmacniacz 1/J
3. **[∫]** - integrator z ω(0) = 0
4. **[Km]** - wzmacniacz km (sprzężenie od i)
5. **[Mobc]** - stała momentu obciążenia

### Konfiguracja w Xcos

**Ustaw kontekst (przykład dla wariantu 1):**
```scilab
R=0.465; L=0.015345; J=2.7; Ke=2.62;
Km=2.62; Uz=100; Mobc=200
```

**Parametry symulacji:**
- Ostateczny czas integracji: `1.5`

**Parametry bloku CLOCK_c:**
- Okres: `0.001` [s] (ważne! mały krok dla dokładności)
- Initialisation Time: `0`

**Parametry integratorów:**
- Pierwszy integrator (dla i): Initial Condition: `0`
- Drugi integrator (dla ω): Initial Condition: `0`

**Parametry monitora dla i(t):**
- Ymin: `0`
- Ymax: `250` (dla uz=100) lub `400` (dla uz=200)
- Refresh period: `1.5`

**Parametry monitora dla ω(t):**
- Ymin: `0`
- Ymax: `30` (dla uz=100) lub `80` (dla uz=200)
- Refresh period: `1.5`

**Alternatywnie: Monitor dwustrumieniowy:**
```
Input ports sizes: 1 1
Ymin vector: 0 0
Ymax vector: 250 30  (dostosuj do wariantu)
Refresh period: 1.5 1.5
Drawing colors: 5 1 5 7 9 11 13 15
```

### Oczekiwane wykresy

**Wariant 1: uz=100V, mobc=200Nm**

Wykres i(t):
```
i(t) [A]
200 ┤     ╱╲
    │    ╱  ╲
150 ┤   ╱    ╲___
    │  ╱          ────___
100 ┤ ╱                  ────___
    │╱                          ───────────
 50 ┼                                      ────
    │
  0 └──┴────┴────┴────┴────┴────┴────┴────┴──→ t[s]
    0  0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  1.5
```
- Początkowy skok do ~190A
- Stabilizacja na ~76A

Wykres ω(t):
```
ω(t) [rad/s]
 25 ┤                           ─────────────────
    │                     ─────╱
 20 ┤                ─────╱
    │           ─────╱
 15 ┤      ─────╱
    │ ─────╱
 10 ┤─────
    │╱
  5 ┤
    │
  0 └──┴────┴────┴────┴────┴────┴────┴────┴──→ t[s]
    0  0.2  0.4  0.6  0.8  1.0  1.2  1.4   1.5
```
- Płynny wzrost od 0 do ~25 rad/s

**Wariant 2: uz=200V, mobc=200Nm**
- i(t): Początkowy skok do ~380A, stabilizacja na ~76A
- ω(t): Wzrost do ~63 rad/s

**Wariant 3: uz=200V, mobc=50Nm**
- i(t): Początkowy skok do ~380A, stabilizacja na ~19A
- ω(t): Wzrost do ~73 rad/s (najszybszy)

### Zadania do wykonania

1. **Zbuduj model** w Xcos zgodnie z wykładem 1.05
2. **Dla każdego wariantu:**
   - Zaktualizuj Uz i Mobc w kontekście
   - Uruchom symulację
   - Zapisz oba wykresy (i(t) i ω(t))
3. **Zmierz z wykresów:**
   - Prąd początkowy (maksimum)
   - Prąd ustalony
   - Prędkość ustaloną
4. **Porównaj** z wartościami teoretycznymi
5. **Zaobserwuj:**
   - Jak uz wpływa na prędkość ustaloną?
   - Jak mobc wpływa na prąd ustalony?
   - Czy przebiegi mają charakterystykę przejściową 1. lub 2. rzędu?

### Wskazówki

- **Model jest sprzężony** - zmiany w obwodzie elektrycznym wpływają na mechaniczny i odwrotnie
- **Mały krok całkowania (0.001s)** jest konieczny ze względu na małą indukcyjność L
- **Zapisuj modele** jako `lab2_silnik_uz[wartość]_mobc[wartość].zcos`
- **Użyj monitora dwustrumieniowego** aby zobaczyć oba przebiegi jednocześnie
- **Weryfikuj wyniki** - prąd ustalony powinien być ≈ mobc/km

### Eksperyment dodatkowy (opcjonalnie)

**Zbadaj wpływ momentu bezwładności J:**

- J = 1.0 kg·m² (mniejsza bezwładność) → szybsze przyspieszenie
- J = 2.7 kg·m² (standard)
- J = 5.0 kg·m² (większa bezwładność) → wolniejsze przyspieszenie

---

## Podsumowanie laboratorium

Po wykonaniu laboratorium powinieneś:

1. **Umieć modelować**:
   - Oscylator harmoniczny tłumiony
   - Silnik obcowzbudny prądu stałego
2. **Rozumieć**:
   - Wpływ tłumienia na oscylacje
   - Sprzężenie między obwodem elektrycznym i mechanicznym silnika
3. **Potrafić analizować**:
   - Przebiegi czasowe zmiennych stanu
   - Stany przejściowe i wartości ustalone
4. **Weryfikować** wyniki z teorią

### Przygotowanie do sprawozdania

**Sprawozdanie powinno zawierać:**

**Zadanie 1:**
- Schemat blokowy modelu
- Wykres x(t)
- Zmierzone wartości: okres T, amplitudy A₁, A₂, A₃
- Obliczony dekrement tłumienia δ
- Porównanie z wartościami teoretycznymi

**Zadanie 2:**
- Schemat blokowy modelu
- Wykresy i(t) i ω(t) dla wszystkich 3 wariantów
- Tabela wartości ustalonych (zmierzonych vs teoretycznych)
- Analiza wpływu uz i mobc na charakterystyki silnika

**Format sprawozdania** - szczegóły na stronie: www.jan.makuch.eu
