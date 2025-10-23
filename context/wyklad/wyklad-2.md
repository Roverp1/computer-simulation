# Wykład 2 - Modelowanie i Symulacja Komputerowa

## Tematy wykładu
- Ruch masy drgającej na równi
- Silnik obcowzbudny prądu stałego
- Oscylatory harmoniczne

---

## Przykład 1.04 - Modelowanie ruchu masy m na równi pochyłej

### Opis zadania
Zbudować model matematyczny, a następnie symulacyjny opisujący ruch x(t) wózka na równi pochyłej o kącie nachylenia alfa.

W układzie jak na rysunku masę m zamocowaną na sprężynie o współczynniku sprężystości k wychylono z położenia równowagi na odległość a i uwolniono.

Wyznaczyć ruch masy przy założeniu, że występuje tarcie toczenia ze współczynnikiem f. Sporządzić wykresy x(t) oraz v(t) = dx/dt.

### Dane do obliczeń
```
x0 = 0.5 [m]
k = 10 [kg/s²]
m = 1 [kg]
g = 10 [m/s²]
f = 0.05
α = 40 [°]
```

### Układ drgający - diagram fizyczny

**Schemat układu:**
```
    ↗ k (sprężyna)
   /
  m (masa na równi)
 /   ↘ f (tarcie)
/α    ↓ x (kierunek ruchu)
────────────────
```

**Siły działające w układzie:**
- T = N * f * znak(v) = mgf * cos(alfa) * znak(v) - siła tarcia
- N = mg * cos(alfa) - siła normalna (reakcja podłoża)
- P = mg - siła ciężkości
- alfa - kąt nachylenia równi

### Równanie ruchu (prawo Newtona)

**Podstawowa forma:**
```
m * a + Σ Fi = 0
```

gdzie:
```
a = d²x/dt²
```

**Rozwinięcie:**
```
m * (d²x/dt²) = -Fs - FT = -k * x - m * g * f * cos(alfa) * znak(v)
```

**Przekształcone równanie różniczkowe:**
```
d²x/dt² = -(k/m) * x - (m * g * f * cos(alfa))/m * sign(dx/dt)
```

**Warunki początkowe:**
```
x(0) = x0
dx/dt|t=0 = 0
```

### Implementacja w Xcos - schemat blokowy

**Opis schematu:**
```
                     Ruch drgający wózka na równi pochyłej

    x'(0) = 0       x(0) = x0
         ↓               ↓
[Σ] → x''(t) → [∫] → x'(t) → [∫] → x(t) → [Monitor]
 ↑                      ↓
 |          [SIGN] ←────┘
 |             ↓
 └←[K/m]←──[g*f*cos(alfa)]
      ↑
      │
   [x(t)]
```

**Uwaga dotycząca funkcji trygonometrycznych:**
- Użyj `g*f*cosd(alfa)` - funkcja `cosd(alfa)` przyjmuje argument w **stopniach**
- Alternatywnie: `g*f*cos(alfa*%pi/180)` - funkcja `cos(alfa)` przyjmuje argument w **radianach**

### Konfiguracja w Xcos

**1. Ustaw kontekst (Widok → Ustaw kontekst):**
```scilab
x0=0.5; g=10; f=0.05; alfa=40; m=1; K=10
```

**2. Ustaw parametry (Symulacja → Ustawienia):**
- Ostateczny czas integracji: `6.5E00`
- Skalowanie czasu rzeczywistego: `0.0E00`

**3. Set CLOCK_c block parameters:**
- Okres: `0.01`
- Initialisation Time: `0`

**4. Set Scope parameters:**
- Input ports sizes: `1`
- Drawing colors (>0) or mark (<0): `1 3 5 7 9 11 13 15`
- Output window number (-1 for automatic): `-1`
- Output window position: `[]`
- Output window sizes: `[]`
- Ymin vector: `-0.6`
- Ymax vector: `0.6`
- Refresh period: `6.5`
- Buffer size: `20`

### Wykres wynikowy

**Charakterystyka wykresu x(t):**
- Przebieg oscylacyjny z tłumieniem
- Amplituda początkowa: 0.5 m
- Oscylacje zanikają do około 0.05 m
- Czas symulacji: 0 do 7 sekund
- Wyraźne tłumienie spowodowane tarciem

**Dane użyte do wykresu:**
```
x0 = 0.5
g = 10
f = 0.05
alfa = 40
m = 1
K = 10
```

---

## Przykład 1.05 - Modelowanie obcowzbudnego silnika elektrycznego prądu stałego

### Opis układu

Sposób działania obcowzbudnego silnika prądu stałego opisuje prosty układ liniowych równań różniczkowych i algebraicznych.

### Schemat ideowy układu silnika

```
        i
    o───┬───o
        │
       uz   
        │   [Motor with rotor ω]
      L─┴─R     m ← mobc
        │       ↓
    o───┴───o
```

### Równania matematyczne

**System równań:**
```
uz = R * i(t) + L * (di(t)/dt) + e(t)
e(t) = ke * ω(t)
m(t) = mobc + mdyn(t)
m(t) = km * i(t)
mdyn(t) = J * (dω(t)/dt)
```

**Symbole literowe w równaniach oznaczają:**
- uz, mobc - napięcie zasilania i moment obciążenia silnika
- i, ω - prąd i prędkość kątowa silnika
- R, L, J, ke, km - stałe silnika
- e - siła elektromotoryczna indukowana w tworniku
- m, mdyn - moment obrotowy i moment dynamiczny silnika

**Warunki początkowe:**
```
i(t = 0) = i0
ω(t = 0) = ω0
i0 = 0
ω0 = 0
```

### Przekształcenie równań

**Wstawiając równanie drugie do pierwszego i wyznaczając pochodną prądu otrzymujemy:**
```
di(t)/dt = (1/L) * uz - (ke/L) * ω(t) - (R/L) * i(t)
```

**Analogicznie wykorzystując trzy kolejne równania, wyznaczamy pochodną prędkości kątowej silnika:**
```
dω(t)/dt = (km/J) * i(t) - (1/J) * mobc
```

**Po prostych przekształceniach otrzymujemy układ dwóch równań różniczkowych wzajemnie od siebie zależnych:**
```
di/dt = (1/L)(uz - ke * ω - R * i)
dω/dt = (1/J)(km * i - mobc)
```

### Dane znamionowe silnika

```
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

### Zmienne dane do obliczeń (przykłady)

**Wariant 1:**
```
uz = 100 [V]
mobc = 200 [Nm]
```

**Wariant 2:**
```
uz = 100 [V]
mobc = 100 [Nm]
```

### Implementacja w Xcos - Model silnika

**Schemat blokowy dla obwodu prądowego (równanie dla i(t)):**
```
                    i(0) = 0
                        ↓
[Uz] → [Σ] → [1/L] → i'(t) → [∫] → i(t) → [Monitor]
        ↑                                ↓
        |←────[R]←──────────────────────┘
        |
        |←────[Ke]←────────┐
                           │
                      [ω(t) z poniżej]
```

**Schemat blokowy dla obwodu mechanicznego (równanie dla ω(t)):**
```
                         ω(0) = 0
                             ↓
[Mobc] → [Σ] → [1/J] → ω'(t) → [∫] → ω(t) → [Monitor]
          ↑
          |
          |←────[Km]←──────[i(t) z góry]
```

**Pełny model silnika - połączenie obu obwodów:**
Obwód prądowy i mechaniczny są sprzężone:
- i(t) wpływa na ω'(t) przez km
- ω(t) wpływa na i'(t) przez ke

### Konfiguracja parametrów

**1. Ustaw kontekst (Widok → Ustaw kontekst):**
```scilab
R=0.465; L=0.015; J=2.7; Ke=2.62;
Km=2.62; Uz=100; Mobc=200
```

Dostęp przez menu: **Widok → Symulacja → Format → Narzędzia**
- Ustawienia
- Wykonaj ślad i analizuj
- **Ustaw kontekst** ← tutaj
- Skompiluj
- Inicjalizacja Modelica
- Start
- Zatrzymaj

**2. Ustaw parametry (Symulacja → Ustawienia):**
```
Ostateczny czas integracji: 1.5E00
Skalowanie czasu rzeczywistego: 0.0E00
Integrator absolutnej tolerancji: 1.0E-06
Integrator względnej tolerancji: 1.0E-06
Tolerancja w czasie: 1.0E-10
Maksymalny przedział czasu całkowania: 1.0000 1E05
Solver kind: Sundials/CVODE - BDF - NEWTON
Maximum step size (0 means no limit): 0.0E00
```

### Wpływ kroku całkowania na wyniki

**Przykład z Okres = 0.1:**

Wykres i(t):
- Początkowy skok do około 100 A
- Stabilizacja na poziomie około 75 A
- Czas przejściowy: około 0.2 s

Wykres ω(t):
- Wzrost od 0 do około 25 obr/s
- Charakterystyka asymptotyczna
- Czas narastania: około 0.6-0.8 s

**Przykład z Okres = 0.001 (dokładniejsze wyniki):**

Wykres i(t):
- Początkowy skok do około 190 A
- Stabilizacja na poziomie około 80 A
- Widoczne są bardziej szczegółowe przebiegi przejściowe

Wykres ω(t):
- Płynniejszy wzrost od 0 do około 25 obr/s
- Lepsza dokładność krzywej przejściowej

**Wniosek:** Mniejszy krok całkowania (0.001 zamiast 0.1) daje dokładniejsze wyniki, szczególnie w stanach przejściowych.

### Parametry monitora jednostrumieniowego

**Dla prądu i(t):**
```
Input ports sizes: 1
Drawing colors (>0) or mark (<0): 5 3 5 7 9 11 13 15
Output window number (-1 for automatic): -1
Output window position: []
Output window sizes: []
Ymin vector: 0
Ymax vector: 200
Refresh period: 1.5
Buffer size: 30
Accept herited events 0/1: 0
Name of Scope (label&id): [empty]
```

**Interpretacja parametrów:**
- **Input ports sizes: 1** - liczba wejść monitora
- **Drawing colors: 5 3 5 7 9 11 13 15** - kolejne cyfry to kolory kolejnych (patrząc od góry monitora) wykresów
- **Ymin vector: 0** - wartość minimalna wykresu
- **Ymax vector: 200** - wartość maksymalna wykresu
- **Refresh period: 1.5** - długość podstawy czasu zgodna z czasem symulacji

**Dla prędkości kątowej ω(t):**
```
Input ports sizes: 1
Drawing colors (>0) or mark (<0): 1 3 5 7 9 11 13 15
Output window number (-1 for automatic): -1
Output window position: []
Output window sizes: []
Ymin vector: 0
Ymax vector: 50
Refresh period: 1.5
Buffer size: 30
Accept herited events 0/1: 0
Name of Scope (label&id): [empty]
```

### Parametry monitora dwustrumieniowego

**Konfiguracja dla wyświetlania obu wykresów i(t) i ω(t):**
```
Input ports sizes: 1 1
Drawing colors (>0) or mark (<0): 5 1 5 7 9 11 13 15
Output window number (-1 for automatic): -1
Output window position: []
Output window sizes: []
Ymin vector: 0 0
Ymax vector: 200 30
Refresh period: 1.5 1.5
Buffer size: 30
Accept herited events 0/1: 0
Name of Scope (label&id): [empty]
```

**Interpretacja parametrów wektorowych:**
- **Input ports sizes: 1 1** - wektor wejść (dwa wejścia)
- **Drawing colors: 5 1 5 7 9 11 13 15** - kolejne cyfry to kolory kolejnych (patrząc od góry monitora) wykresów
- **Ymin vector: 0 0** - wektor Ymin wykresów
- **Ymax vector: 200 30** - wektor Ymax wykresów
- **Refresh period: 1.5 1.5** - wektor długości podstawy czasu zgodny z czasem symulacji

### Wyniki dla różnych danych

**Zmienne dane: uz = 100 [V], mobc = 100 [Nm]**

Wykres górny - i(t) [A]:
- Początkowy skok do około 175 A
- Stabilizacja na poziomie około 40 A
- Czas przejściowy: około 0.3 s

Wykres dolny - ω(t) [obr/s]:
- Wzrost od 0 do około 30 obr/s
- Płynna charakterystyka narastania
- Czas narastania: około 0.6 s

### Uproszczony model z blokami Expression

**Zamiast osobnych bloków można użyć bloków Expression:**

**Dla obwodu prądowego:**
```
Expression: (Uz - Ke*u1 - R*u2)/L
gdzie:
  u1 = ω (wejście 1)
  u2 = i (wejście 2)
```

**Dla obwodu mechanicznego:**
```
Expression: (Km * u1 - Mobc)/J
gdzie:
  u1 = i (wejście 1)
```

Ten schemat jest bardziej kompaktowy i łatwiejszy do modyfikacji.

---

## Zadanie 2.01 - Modelowanie oscylatora harmonicznego tłumionego bez tarcia

### Opis układu

Rysunek przedstawia schemat układu złożonego z masy połączonej z nieruchomą podporą poprzez sprężynę i tłumik **bez uwzględnienia zjawiska tarcia** oraz układ uwolniony od więzów.

**Schemat fizyczny:**
```
┌──────┐      
│      │──────→ x
│  c   │      
├──┬───┤      
   │         cẋ (siła tłumienia)
   m    ←─── kx (siła sprężyny)
   │         
///│///
   │
```

### Równanie ruchu

**Równanie ruchu na podstawie II zasady dynamiki Newtona:**
```
m * (d²x/dt²) + c * (dx/dt) + kx = 0
```

**Warunki początkowe:**
```
x(0) = a
```

**Podstawą do zbudowania modelu symulacyjnego będzie równanie:**
```
d²x/dt² = (1/m)(-c * (dx/dt) - kx)
```

**Warunki początkowe:**
```
x(0) = a
```

### Dane do obliczeń

```
m = 0.5
c = 0.2
k = 5
a = 0.5
```

### Implementacja w Xcos

**Schemat blokowy:**
```
            x'(0) = 0       x(0) = a
                ↓               ↓
[Σ] → [1/m] → x''(t) → [∫] → x'(t) → [∫] → x(t) → [Monitor]
 ↑                         ↓
 |←─────[c]←───────────────┘
 |
 |←─────[K]←────────────────────────┘
```

**Ustawienia:**
- Krok całkowania: h = 0.01

**Równanie:**
```
d²x/dt² = (1/m)(-c * (dx/dt) - kx)
```

### Wykres wynikowy x(t)

**Charakterystyka:**
- Drgania tłumione
- Amplituda początkowa: 0.5 m
- Amplituda zanika wykładniczo
- Okres drgań: około 2 s
- Amplituda po 15 s: praktycznie zero
- Widoczne są klasyczne oscylacje z tłumieniem podkrytycznym

**Dane:**
```
m = 0.5
c = 0.2
k = 5
a = 0.5
```

---

## Zadanie 2.02 - Modelowanie oscylatora harmonicznego nietłumionego z tarciem suchym

### Opis układu

Rysunek przedstawia schemat układu złożonego z masy połączonej z nieruchomą podporą poprzez sprężynę **z uwzględnieniem zjawiska tarcia** oraz układ uwolniony od więzów.

**Schemat fizyczny:**
```
┌──────┐      
│      │──────→ x        → x
│      │               
│  k   │──────┐      kx
└──────┘      │   
              m  ←─── T = μN sign(ẋ)
            -----      
           ///////     N ↑ (siła normalna)
```

### Równanie ruchu

**Równanie ruchu na podstawie II zasady dynamiki Newtona:**
```
m * (d²x/dt²) + μN * sign(dx/dt) + kx = 0
```

gdzie:
```
N = m * g
```

**Warunki początkowe:**
```
x(0) = a
```

**Podstawą do zbudowania modelu symulacyjnego będzie równanie:**
```
d²x/dt² = (1/m)(-μmg * sign(dx/dt) - kx)
```

**Warunki początkowe:**
```
x(0) = a
```

### Dane do obliczeń

```
m = 0.5
μ = 0.02
k = 5
a = 0.5
g = 9.81
```

### Implementacja w Xcos

**Schemat blokowy:**
```
            x'(0) = 0       x(0) = a
                ↓               ↓
[Σ] → [1/m] → x''(t) → [∫] → x'(t) → [∫] → x(t) → [Monitor]
 ↑                         ↓
 |         [Expression]←───┘
 |         m*g*mi*sign(u1)
 |
 |←─────[K]←────────────────────────┘
```

**Ustawienia:**
- Krok całkowania: h = 0.01

**Równanie:**
```
d²x/dt² = (1/m)(-μmg * sign(dx/dt) - kx)
```

**Blok Expression:**
```
Expression: m * g * mi * sign(u1)
gdzie u1 = x'(t)
```

### Wykres wynikowy x(t)

**Charakterystyka:**
- Drgania z tarciem suchym
- Amplituda początkowa: 0.5 m
- Charakterystyczny kształt z gwałtownym tłumieniem
- Oscylacje zanikają szybciej niż w przypadku tłumienia lepkiego
- Po około 10-11 sekundach drgania praktycznie ustają
- Widoczny efekt tarcia suchego - amplituda zmniejsza się liniowo

**Dane:**
```
m = 0.5
μ = 0.02
k = 5
a = 0.5
g = 9.81
```

**Różnica w porównaniu do zadania 2.01:**
- W zadaniu 2.01 (tłumienie lepkie): zanik wykładniczy amplitudy
- W zadaniu 2.02 (tarcie suche): zanik zbliżony do liniowego, charakterystyczny dla tarcia Coulomba

---

## Podsumowanie wykładu 2

### Główne zagadnienia:
1. **Modelowanie ruchu masy na równi pochyłej** - uwzględnienie tarcia, sprężyny, sił grawitacji
2. **Silnik obcowzbudny prądu stałego** - układ dwóch sprzężonych równań różniczkowych
3. **Oscylatory harmoniczne** - z tłumieniem lepkim i tarciem suchym

### Kluczowe techniki w Xcos:
- Budowa modeli z równań różniczkowych drugiego rzędu
- Używanie bloków Expression do złożonych obliczeń
- Konfiguracja parametrów symulacji (krok całkowania, czas symulacji)
- Konfiguracja monitorów jedno- i dwustrumieniowych
- Wpływ kroku całkowania na dokładność wyników

###Ważne funkcje Scilab:
- `sign(x)` - funkcja signum
- `cosd(alfa)` - cosinus kąta w stopniach
- `cos(alfa)` - cosinus kąta w radianach
- Definiowanie parametrów w kontekście

### Parametry do zapamiętania:
- Mniejszy krok całkowania = większa dokładność (ale dłuższy czas obliczeń)
- Konfiguracja monitora: Input ports sizes, Ymin, Ymax, Refresh period
- Kolory wykresów: wektor cyfr w Drawing colors
