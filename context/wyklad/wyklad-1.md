# Wykład 1 - Modelowanie i Symulacja Komputerowa

## Pakiet SciLab - Xcos

## Wprowadzenie do środowiska Scilab

### Informacje ogólne
- **Scilab jest darmowym środowiskiem do obliczeń naukowych** rozprowadzanym na licencji open source
- Na stronie projektu **www.scilab.org** można znaleźć:
  - Wersje instalacyjne pakietu
  - Dokumentację
  - Wiele opracowań pomocnych podczas nauki jego użytkowania
- **Scilab jest pewnego rodzaju darmowym zamiennikiem komercyjnego pakietu MatLab**
- Dokumentacja na stronie projektu Scilab: **www.scilab.org/resources/documentation**

### Konsola Scilab

**Po uruchomieniu środowiska pojawia się konsola postaci:**

```
┌─────────────────────────────────────────────────────────┐
│ Scilab 6.0.1 Console                                    │
│ Plik  Edycja  Sterowanie  Narzędzia  ?                 │
│ [Ikony narzędziowe]                      [Xcos ikona]   │
├─────────────────────────────────────────────────────────┤
│ Przeglądarka plików                                     │
│   edmotu_2021-22\go                                     │
│                                                         │
│ Scilab 6.0.1 Console                    Przeglądarka   │
│                                         zmiennych       │
│ Wykonanie rozruchu:                     Nazwa  Value    │
│   ładowanie środowiska początkowego     ans    0       │
│                                                         │
│ --> |                                                   │
│                                         Historia poleceń │
│                                         [command history]│
│                                                         │
│                                         News feed       │
│                                         Internet Of Thi..│
│                                                         │
│                                         Internet Of Things│
│                                         with Scilab 6.1 │
└─────────────────────────────────────────────────────────┘
```

**Elementy interfejsu:**
- **Okno główne (centralne)** - konsola, w której wpisujemy instrukcje Scilab
- **Przeglądarka plików** (lewy panel) - dostęp do plików projektów
- **Przeglądarka zmiennych** (prawy górny panel) - wyświetla zmienne w workspace
- **Historia poleceń** (prawy środkowy panel) - historia wykonanych komend
- **News feed** (prawy dolny panel) - aktualności o Scilab
- **Xcos ikona** - w pasku narzędzi (dziewiąta ikona) służy do uruchomienia modułu Xcos

**Sposób pracy:**
- W środkowym oknie można wpisywać bezpośrednio instrukcje w języku Scilab (podobnie jak w języku MatLab)
- **Wyniki otrzymujemy natychmiast ponieważ jest to interpreter**
- Prompt `-->` wskazuje gotowość do wprowadzenia kolejnej komendy

## Podstawowe polecenia Scilab

| Polecenie | Znaczenie |
|-----------|-----------|
| `x+y`, `x-y`, `x*y`, `x/y`, `x^y` | Podstawowe operacje arytmetyczne |
| `sqrt(5)` | Pierwiastek: √5 |
| `log(5)` | Logarytm naturalny: ln(5) |
| `log10(5)` | Logarytm dziesiętny: log(5) |
| `sin(x)` | Sinus (argument w radianach): sin(x[rad]) |
| `sind(x)` | Sinus (argument w stopniach): sin(x[°]) |
| `%pi` | Liczba π = 3.141592653 |
| `%e` | Liczba e = 2.71828182 |
| `X=156.98*%pi/sind(45)` | Przykład użycia: X=156.98*π/sin(45°) |
| `A=[1 2 3]` | Definicja wektora (wiersz): A=[1 2 3] |
| `B=[1; 2; 3]` | Definicja wektora (kolumna): B=[1; 2; 3] |
| `A*B` | Mnożenie wektorów (wynik to skalar) |
| `B*A` | Mnożenie wektorów (wynik to macierz) |

### Przykłady obliczeń
```scilab
--> A=sin(%pi/2)
A =
    1.

--> A=[1 2 3];  B=[1; 2; 3]
B =
    1.
    2.
    3.

--> A*B
ans =
    14.

--> B*A
ans =
    1.  2.  3.
    2.  4.  6.
    3.  6.  9.
    (wynik to macierz)
```

## Obliczanie całek

### Obliczenia analityczne
```
F(x) = ∫ f(x)dx

∫[a to b] f(x)dx = F(b) - F(a)
```

### Obliczenia numeryczne
```
∫[a to b] f(x)dx = Σ Si
```
gdzie Si to pole prostokąta o szerokości Δx

## Rozwiązywanie numeryczne równań różniczkowych

Równanie różniczkowe postaci:
```
y''(t) = f(y'(t), y(t), t)
```

z warunkami początkowymi: `y'(0)` i `y(0)`

**W językach symulacyjnych rozwiązanie opiera się na ciągu bloków całkujących:**

```
y''(t) → [∫] → y'(t) → [∫] → y(t)
       y'(0)         y(0)
```

Blok sumatora oblicza wartość funkcji `f(y'(t), y(t), t)`, która jest następnie dwukrotnie całkowana.

## Moduł Xcos

### Uruchamianie
- Wpisując w konsoli polecenie **"xcos"** lub
- Klikając dziewiątą ikonę na pasku skrótów

### Zasada działania
- Podobnie jak dla MatLab **model symulacyjny ma postać schematu blokowego**
- Schemat budujemy wykorzystując **gotowe bloki dostępne w przeglądarce palet**
- Bloki z Przeglądarki **"przeciągamy"** (używając lewego klawisza myszki) na obszar okna projektu
- Później możemy je **łączyć między sobą** tworząc schemat blokowy czyli model symulacyjny układu

### Interfejs Xcos

**Okno Xcos składa się z dwóch głównych części:**

```
┌─────────────────────┬───────────────────────────────────────────┐
│ Przeglądarka palet  │         *Bez tytułu - 14:51:11 - Xcos    │
│       - Xcos        │                                           │
│ Palety  Widok       │ Plik Edycja Widok Symulacja Format Narzę │
│ [Ikony nawigacji]   │ [Ikony narzędziowe]                  [?]  │
├─────────────────────┤ *Bez tytułu - 14:51:11 - Xcos             │
│ Przeglądarka palet  │                                           │
│ ● Palety            │                                           │
│   ● Recently Used   │    Okno projektu                          │
│   ● Systemy czasu   │    (tutaj budujemy schemat blokowy)       │
│     ciągłego        │                                           │
│   ● Nieciqgłość     │                                           │
│   ● Systemy czasu   │                                           │
│     dyskretnego     │                                           │
│   ● Wyszukiwanie    │                                           │
│     odnośników      │                                           │
│   ● Obsługa zdarzeń │                                           │
│   ● Liczba całkowita│                                           │
│   ● Port & Podsystem│                                           │
│   ● Wykrywanie      │                                           │
│     przełączenia... │                                           │
│   ● Trasowanie      │                                           │
│     (Routing) sygn..│                                           │
│   ● Bezwarunkowy    │                                           │
│   ● Adnotacje       │                                           │
│   ● Sinks           │                                           │
│   ● Operacje Matem..│                                           │
│   ● Źródła          │                                           │
│   ● Termo-hydraul...│                                           │
│   ● Bloki demons... │                                           │
│   ● Funkcje zdefin..│                                           │
└─────────────────────┴───────────────────────────────────────────┘
```

**Przeglądarka palet (lewy panel):**
- Zawiera hierarchiczne drzewo kategorii bloków
- Główne kategorie:
  - Recently Used Blocks - ostatnio używane bloki
  - Systemy czasu ciągłego - bloki całkowania, inercji, opóźnień
  - Nieciqgłość - bloki z histerezą, nasyceniem, strefą martwą
  - Systemy czasu dyskretnego
  - Wyszukiwanie odnośników
  - Obsługa zdarzeń
  - Port & Podsystem - do tworzenia podsystemów
  - Trasowanie (Routing) sygnału - MUX, DEMUX
  - Sinks - monitory, wyświetlacze
  - Operacje Matematyczne - sumatory, mnożniki
  - Źródła - generatory sygnałów, stałe
  - Funkcje zdefiniowane przez użytkownika - Expression, SUPER_f

**Przykład zawartości palety "Systemy czasu ciągłego":**
```
Po kliknięciu kategorii wyświetlają się bloki:
┌─────────────────────────────────────────┐
│ DUMMY_CLSS   CLR        CLSS            │
│ CLINDUMMY_f  CLR        CLSS            │
├─────────────────────────────────────────┤
│ DERIV        INTEGRAL_f  INTEGRAL_m     │
│ (du/dt)      (1/s)      (∫)             │
├─────────────────────────────────────────┤
│ PID          TCLSS      TIME_DELAY      │
│              Jump       Continuous      │
│              (A,B,C,D)  fix delay       │
├─────────────────────────────────────────┤
│ VARIABLE_DELAY  PDE                     │
│ Variable delay  PDE                     │
└─────────────────────────────────────────┘
```

**Okno projektu (prawy panel):**
- Obszar roboczy do budowania schematów blokowych
- Bloki przeciąga się z Przeglądarki palet (lewym przyciskiem myszy)
- Bloki łączy się liniami reprezentującymi przepływ sygnałów
- Pasek narzędzi zawiera ikony do:
  - Zapisywania projektu
  - Uruchamiania symulacji (trójkąt play)
  - Zatrzymywania symulacji
  - Powiększania/pomniejszania widoku
  - Ustawień symulacji (ikona koła zębatego)

## Ikony wybranych bloków i opis realizowanych operacji

### Systemy czasu ciągłego (Paleta: Systemy czasu ciągłego)

| Blok | Operacja | Paleta |
|------|----------|--------|
| Integrator | `y = ∫[0 to t] x dr + y(0)` | Systemy czasu ciągłego |
| Continuous fix delay | `y = x(t - T₀)` | Systemy czasu ciągłego |
| Człon inercyjny pierwszego rzędu: `K/(1+s*T)` | `T(dy/dt) + y = K * x` | Systemy czasu ciągłego |
| Człon inercyjny drugiego rzędu: `K/(T1*s² + T2*s + 1)` | `T1(d²y/dt²) + T2(dy/dt) + y = K * x` | Systemy czasu ciągłego |
| Różniczkowanie: `du/dt` | `y = dx/dt` | Systemy czasu ciągłego |

### Źródła (Paleta: Źródła)

| Blok | Operacja | Paleta |
|------|----------|--------|
| Stała: `A` | `y = A` | Źródła |
| Skok jednostkowy | `y = 1(t) = {0 dla t < T₀; 1 dla t ≥ T₀}` | Źródła |
| Generator sygnału sinusoidalnego | `y = A * sin(ωt + φ)` | Źródła |
| Rampa | `y = k * t` | Źródła |
| Zegar | `y = t` | Źródła |

### Operacje matematyczne (Paleta: Operacje matematyczne)

| Blok | Operacja | Paleta |
|------|----------|--------|
| Funkcja sinus: `SIN` | `y = sin(x[rad])` | Operacje matematyczne |
| Potęgowanie: `u^a` | `y = x^a` | Operacje matematyczne |
| Wykładnicza: `a^u` | `y = a^x` | Operacje matematyczne |
| Sumator: `+/- Σ` | `y = x1 - x2` (liczba wejść i ich znaki do ustalenia) | Operacje matematyczne |
| Mnożenie: `×/÷ Π` | `y = x1/x2` (liczba wejść i ich znaki do ustalenia) | Operacje matematyczne |
| Wzmacniacz: `K` | `y = k * x` | Operacje matematyczne |

### Nieciągłości (Paleta: Nieciągłości)

| Blok | Operacja | Paleta |
|------|----------|--------|
| Element z nasyceniem | element z nasyceniem | Nieciągłości |
| Histereza | histereza | Nieciągłości |
| Element ze strefą martwą | element ze strefą martwą | Nieciągłości |

### Funkcje definiowane przez użytkownika

| Blok | Opis | Paleta |
|------|------|--------|
| Expression (1 wejście) | `y = w*w*sin(u1)` - funkcja zdefiniowana przez użytkownika, liczba wejść: 1, scilab expression: `w*w*sin(u1)` | Funkcje zdefiniowane przez użytkownika |
| Expression (2 wejścia) | `y = n*(1-b*b*sin(u1)^2)*u2` - funkcja zdefiniowana przez użytkownika, liczba wejść: 2, scilab expression: `n*(1-b*b*sin(u1)^2)*u2` | Funkcje zdefiniowane przez użytkownika |
| SUPER_f | Funkcja zdefiniowana jako podsystem | Funkcje zdefiniowane przez użytkownika |

### Systemy czasu ciągłego - Regulator PID

| Blok | Opis | Paleta |
|------|------|--------|
| PID | Set PID parameters: Proportional (K), Integral (Tc), Derivation (Td) | Systemy czasu ciągłego |

### Wyszukiwanie odnośników

| Blok | Opis | Paleta |
|------|------|--------|
| Interp | Set interpolation block parameters: X coord. `[-2:0.5:1]`, Y coord. `[10, 14, 16, 17, 20, 21, 25]` | Wyszukiwanie odnośników |

### Trasowanie (Routing) sygnału

| Blok | Operacja | Paleta |
|------|----------|--------|
| MUX (Multiplekser) | łączenie sygnałów w wektor | Trasowanie (Routing) sygnału |
| DEMUX (Demultiplekser) | rozdzielanie wektora sygnałów | Trasowanie (Routing) sygnału |

### Źródła i Sinks (monitory)

| Blok | Opis | Paleta |
|------|------|--------|
| Zegar + Monitor z wykresem x(t) | Blok sterujący procesem obliczeń. Określa krok całkowania i czas inicjalizacji wykresu x(t). Monitor z wykresem x(t) | Źródła i Sinks |
| Monitor z wykresami X1() i x2(t) | Monitor z wykresami X1() i x2(t). Można ustawić więcej sygnałów wejściowych. | Źródła i Sinks |
| Monitor graficzny y(x) | Monitor graficzny uzyskujemy wykres y(x) czyli X2(x1) | Źródła i Sinks |

## Odwracanie bloków o więcej niż jednym wejściu

**Menu: Format → Lustro**

### Przykłady odwracania sumatora
```
Normalnie: x1 → [+/-Σ] → y = x1 - x2
          x2 →

Po odwróceniu: [+/-Σ] ← x1 → y = -x1 + x2
                      ← x2
```

**Uwaga:** Po odwróceniu bloku **znaki wejść mogą się zmienić**!

### Przykłady odwracania dzielenia
```
Normalnie: x1 → [×/÷Π] → y = x1/x2
          x2 →

Po odwróceniu: [×/÷Π] ← x1 → y = x2/x1
                      ← x2
```

### Przykład z zachowaniem operacji
Dla bloku Expression z funkcją `y = u1 + 2*u2`:
- Po odwróceniu bloku kolejność wejść może się zmienić (u2 przed u1)
- Ale operacja pozostaje ta sama: `y = u1 + 2*u2`

## Budowanie symulacyjnego schematu blokowego na podstawie równania różniczkowego

### Procedura ogólna

Niech równanie różniczkowe ma postać:
```
T1(d²y/dt²) + T2(dy/dt) + y = Kx(t)
```
warunki początkowe: `y'(0) = a`, `y(0) = b`

**Krok 1:** Po prostych przekształceniach otrzymujemy:
```
d²y/dt² = (1/T1)(-T2(dy/dt) - y + Kx(t))
```
warunki początkowe: `y'(0) = a`, `y(0) = b`

**Krok 2:** Pamiętamy, że **"blok całkowania" ma właściwość całkowania sygnału wejściowego**. Oczywiście musimy także **zadbać o zadanie warunku początkowego**.

**Krok 3:** Możemy zauważyć, że tworząc **łańcuch bloków całkujących** dla równania różniczkowego n-tego rzędu otrzymamy ciąg postaci jak niżej, gdzie na wyjściu ostatniego bloku całkującego będzie funkcja y(t) będąca rozwiązaniem równania różniczkowego:

```
d^n y/dt^n → [∫] → d^(n-1) y/dt^(n-1) → ... → dy/dt → [∫] → y(t)
           y^(n-1)(0)                          y(0)
```

### Konstrukcja schematu

Dla równania, **po wyciągnięciu współczynnika 1/T1 przed nawias**, konstruujemy ciąg bloków całkujących postaci:

```
d²y/dt² → [∫] → dy/dt → [∫] → y(t)
        y'(0)=a       y(0)=b
```

**Korzystając z dostępnych sygnałów dy/dt oraz y(t) oraz innych bloków funkcyjnych budujemy blokowy schemat symulacyjny równania różniczkowego.**

### Przykładowy schemat dla równania drugiego rzędu

```
np. x(t) = A
    ↓
   [A] → [K] → [+Σ] → [1/T1] → d²y/dt² → [∫] → dy/dt → [∫] → y(t) → [Monitor]
                ↑                      y'(0)=a      y(0)=b
                |                         ↓
                └─────────[T2]───────────┘
                            ↑
                            └──────────[feedback od y(t)]
```

## Ustawianie parametrów w Xcos

### Ustaw kontekst (Context)

**Dostęp przez menu:**
```
Widok → Ustaw kontekst
```

Lub przez pasek narzędzi:
```
Plik  Edycja  Widok  Symulacja  Format  Narzędzia  ?
              │
              └──→ [Dropdown menu]
                   ┌─────────────────────────┐
                   │ ● Ustawienia            │
                   │ ● Wykonaj ślad i analizuj│
                   │ ● Ustaw kontekst    ← ! │
                   │   Skompiluj             │
                   │   Inicjalizacja Modelica│
                   │ ▷ Start                 │
                   │ ● Zatrzymaj             │
                   └─────────────────────────┘
```

**Okno dialogowe "Ustaw kontekst":**
```
┌────────────────────────────────────────────────┐
│ ⚙ Ustaw kontekst                              │
│                                                │
│ You may enter here scilab instructions to     │
│ define definitions using Scilab instructions. │
│ These instructions are evaluated once confirm │
│ diagram is loaded).                           │
│                                                │
│ ┌──────────────────────────────────────────┐ │
│ │ A=1; T1=2; T2=3; K=2; a=0; b=0.2         │ │
│ │                                          │ │
│ │                                          │ │
│ └──────────────────────────────────────────┘ │
│                                                │
│                  [ OK ]    [ Anuluj ]         │
└────────────────────────────────────────────────┘
```

**Przykład:**
```scilab
A=1; T1=2; T2=3; K=2; a=0; b=0.2
```

**Zastosowanie:**
- Definiowanie parametrów modelu w jednym miejscu
- Parametry są dostępne we wszystkich blokach
- Ułatwia modyfikację wartości bez zmiany wielu bloków
- Instrukcje są wykonywane przy ładowaniu diagramu

### Parametry bloków

#### Set Constant Block
```
┌────────────────────────────────┐
│ ⚙ Set Contant Block           │
│                                │
│ Constant    │ A │              │
│             └───┘              │
│                                │
│        [ OK ]    [ Anuluj ]    │
└────────────────────────────────┘
```
- Constant: `A` (nazwa zmiennej z kontekstu) lub bezpośrednia wartość liczbowa np. `5`

#### Set sum block parameters
```
┌──────────────────────────────────────────────────┐
│ ⚙ Set sum block parameters                      │
│                                                  │
│ Datatype (1=real double 2=complex 3=int32 ...)  │
│ │ 1 │                                            │
│ └───┘                                            │
│                                                  │
│ Number of inputs or sign vector (of +1, -1)     │
│ │ [1; -1; -1] │                                  │
│ └─────────────┘                                  │
│                                                  │
│                     [ OK ]    [ Anuluj ]         │
└──────────────────────────────────────────────────┘
```
- Datatype: `1` (real double)
- Number of inputs or sign vector: `[1; -1; -1]` oznacza 3 wejścia: +x1 -x2 -x3

**Interpretacja parametru "Inputs ports signs/gain":**
- `[1; -1]` → y = x1 - x2
- `[1; 1]` → y = x1 + x2
- `[1; -1; -1]` → y = x1 - x2 - x3
- `[2; -3]` → y = 2*x1 - 3*x2

#### Ustaw parametry symulacji
```
┌──────────────────────────────────────────────────┐
│ ⚙ Ustaw parametry                                │
│                                                  │
│ Ostateczny czas integracji    │ 10 │            │
│                               └────┘            │
│                                                  │
│ Skalowanie czasu rzeczywistego│ 0.0E00 │        │
│                               └────────┘        │
│                                                  │
│                     [ OK ]    [ Anuluj ]         │
└──────────────────────────────────────────────────┘
```
- Ostateczny czas integracji: `10` - czas trwania symulacji w sekundach
- Skalowanie czasu rzeczywistego: `0.0E00` - symulacja wykonywana jak najszybciej

#### Set CLOCK_c block parameters
```
┌────────────────────────────────────────────────────┐
│ ⚙ Set CLOCK_c block parameters                    │
│                                                    │
│ Event clock generator                              │
│                                                    │
│ Do not start if 'Initialisation Time' is negative │
│                                                    │
│ Okres                 │ 0.01 │                     │
│                       └──────┘                     │
│                                                    │
│ Initialisation Time   │ 0 │                        │
│                       └───┘                        │
│                                                    │
│                [ OK ]         [ Anuluj ]           │
└────────────────────────────────────────────────────┘
```
- **Okres: `0.01`** - krok całkowania (im mniejszy, tym większa dokładność, ale dłuższy czas obliczeń)
- **Initialisation Time: `0`** - czas rozpoczęcia generowania zdarzeń

**Uwaga:** Blok CLOCK_c steruje **procesem obliczeń** - określa krok całkowania i czas inicjalizacji wykresu

#### Set Integral block parameters
```
┌────────────────────────────────────┐
│ ⚙ Set Integral block parameters   │
│                                    │
│ Initial Condition   │ a │          │
│                     └───┘          │
│                                    │
│           [ OK ]    [ Anuluj ]     │
└────────────────────────────────────┘
```
- Initial Condition: `a` - warunek początkowy dla pierwszego integratora
- Dla drugiego integratora użyj: `b`

**Związek z równaniem różniczkowym:**
```
d²y/dt² → [∫] → dy/dt → [∫] → y(t)
        y'(0)=a       y(0)=b
```

#### Set Scope parameters (Monitor)
```
┌──────────────────────────────────────────────────────┐
│ ⚙ Set Scope parameters                               │
│                                                      │
│ Color (>0) or mark (<0) vector (8 entries)          │
│ │ 5 1 3 7 9 11 13 15 │                              │
│ └────────────────────┘                              │
│                                                      │
│ Output window number (-1 for automatic)             │
│ │ -1 │                                              │
│ └────┘                                              │
│                                                      │
│ Output window position                              │
│ │ [] │                                              │
│ └────┘                                              │
│                                                      │
│ Output window sizes                                 │
│ │ [600;400] │                                       │
│ └───────────┘                                       │
│                                                      │
│ Ymin                                                │
│ │ -15 │                                             │
│ └─────┘                                             │
│                                                      │
│ Ymax                                                │
│ │ 15 │                                              │
│ └────┘                                              │
│                                                      │
│ Refresh period                                      │
│ │ 10 │                                              │
│ └────┘                                              │
│                                                      │
│ Buffer size                                         │
│ │ 20 │                                              │
│ └────┘                                              │
│                                                      │
│ Accept herited events 0/1                           │
│ │ 0 │                                               │
│ └───┘                                               │
│                                                      │
│ Name of Scope (label&id)                            │
│ │ wykres Y(t) │                                     │
│ └─────────────┘                                     │
│                                                      │
│                  [ OK ]         [ Anuluj ]          │
└──────────────────────────────────────────────────────┘
```

**Interpretacja parametrów:**
- **Color vector: `5 1 3 7 9 11 13 15`**
  - Kolejne cyfry to **numery kolorów** dla kolejnych wykresów (od góry monitora)
  - Liczby >0: linie ciągłe w danym kolorze
  - Liczby <0: markery w danym kolorze
  
- **Output window number: `-1`**
  - `-1` - automatyczny numer okna

- **Output window position: `[]`**
  - Pusta tablica - pozycja domyślna

- **Output window sizes: `[600;400]`**
  - Szerokość: 600 pikseli
  - Wysokość: 400 pikseli

- **Ymin: `-15`**
  - Minimalna wartość osi Y

- **Ymax: `15`**
  - Maksymalna wartość osi Y

- **Refresh period: `10`**
  - Okres odświeżania wykresu (powinien być zgodny z czasem symulacji)

- **Buffer size: `20`**
  - Rozmiar bufora danych

- **Accept herited events: `0`**
  - 0 - nie akceptuj dziedziczonych zdarzeń
  - 1 - akceptuj dziedziczone zdarzenia

- **Name of Scope: `wykres Y(t)`**
  - Etykieta okna wykresu

## Uruchomienie symulacji

### Krok 1: Start symulacji
Kliknąć ikonę **start obliczeń** (trójkąt play ▷ na pasku narzędzi)

**Pasek narzędzi Xcos:**
```
Plik  Edycja  Widok  Symulacja  Format  Narzędzia  ?
[💾] [📁] [🖨️] [📋] [📐] [✂️] [📄] [🔧] [▷] [⏸] [🔍] [🔎] [⚙️] [?]
                                     ↑
                                 Start obliczeń
```

### Krok 2: Pojawienie się wykresu
Po uruchomieniu symulacji pojawi się okno graficzne z wykresem:

```
┌─────────────────────────────────────────────────┐
│ Okno graficzne numer 20007                  - □ × │
│ Plik  Narzędzia  Edycja  ?                      │
│ [💾] [🔍] [🔎] [🖼] [📊] [⟲] [?]                  │
├─────────────────────────────────────────────────┤
│ Okno graficzne numer 20007                      │
│ ┌───────────────────────────────────────────┐   │
│ │ 15 ┐                                      │   │
│ │ 10 ┤         ___________________          │   │
│ │  5 ┤       /                              │   │
│ │  0 ┼──────┘                               │   │
│ │ -5 ┤                                      │   │
│ │-10 ┤                                      │   │
│ │-15 ┴──┬────┬────┬────┬────┬────┬────┬──  │   │
│ │    0  1    2    3    4    5    6    7    │   │
│ │                     t                     │   │
│ └───────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

### Krok 3: Dopasowanie wykresu (jeśli potrzebne)

**Jeżeli wartości Ymin i Ymax dla okna graficznego będą źle ustawione:**

1. **Kliknij ikonę LUPKI** (czwarta od lewej na pasku okna graficznego: 🔍)
2. Wykres zostanie **automatycznie dopasowany** do rozmiarów okna

**Ikony w oknie graficznym:**
```
[💾] - Zapisz wykres
[🔍] - Zoom in (powiększ)
[🔎] - Zoom out (pomniejsz)
[🖼] - Dopasuj wykres do okna ← ! (LUPKA)
[📊] - Eksportuj wykres
[⟲] - Odśwież
[?] - Pomoc
```

### Interpretacja wykresu

**Elementy wykresu:**
- **Oś X** - czas symulacji [s]
- **Oś Y** - wartość sygnału (jednostka zależna od modelu)
- **Linia wykresu** - przebieg sygnału w czasie
- **Kolor linii** - zgodny z parametrem "Color vector" w ustawieniach Scope

**Przykład odczytu:**
- W czasie t=0s wartość y=0
- W czasie t=1s wartość y≈5
- W czasie t=3s wartość y≈10 (wartość ustabilizowana)

## Przykład 1.01 - Modelowanie obwodu RL

### Schemat obwodu elektrycznego

Rozpatrzmy układ RL postaci:

```
        L       R
    o─────∩∩∩∩∩─────┬──o
    |                |
  e(t)             i(t)
    |                |
    o────────────────┴──o
```

**Gdzie:**
- L - indukcyjność cewki [H]
- R - rezystancja [Ω]
- e(t) - źródło napięcia [V]
- i(t) - prąd w obwodzie [A]

### Równanie obwodu

**Równanie według prawa Kirchhoffa:**
```
L * (di(t)/dt) + R * i(t) = e(t)
```
gdzie `e(t) = E = const` (napięcie stałe)

**Przekształcenie do postaci z pochodną:**
```
di/dt = (1/L) * (E - R * i(t))
```

**Warunek początkowy:**
```
i(0) = 0  (brak prądu początkowego)
```

### Schemat blokowy w Xcos

**Implementacja w Xcos:**

```
┌──────────────────────────────────────────────────────────┐
│                                                          │
│           i(0) = 0                                       │
│               ↓                                          │
│  [E] → [Σ] → [1/L] → i'(t) → [∫] → i(t) → [Monitor]    │
│        - ↑                                  │            │
│          |                                  │            │
│          └──────────[R]←────────────────────┘            │
│                                                          │
│  E=5; L=4; R=2                                          │
└──────────────────────────────────────────────────────────┘
```

**Szczegółowy opis przepływu sygnałów:**

1. **[E]** - blok stałej (Constant) generuje napięcie zasilania E
2. **[Σ]** - sumator z wejściami:
   - Wejście górne (+): E
   - Wejście dolne (-): R * i(t) (sprzężenie zwrotne)
   - Wyjście: E - R * i(t)
3. **[1/L]** - wzmacniacz o wzmocnieniu 1/L
   - Wyjście: i'(t) = (1/L) * (E - R * i(t))
4. **[∫]** - integrator z warunkiem początkowym i(0) = 0
   - Wyjście: i(t)
5. **[R]** - wzmacniacz o wzmocnieniu R
   - Wejście: i(t)
   - Wyjście: R * i(t) (feedback do sumatora)
6. **[Monitor]** - wyświetlacz wykresu i(t)

### Konfiguracja parametrów

**Ustaw kontekst (Widok → Ustaw kontekst):**
```scilab
E=5; L=4; R=2
```

**Parametry bloku CLOCK_c:**
- Okres: `0.01` [s]
- Initialisation Time: `0`

**Parametry bloku Scope:**
- Ymin: `0`
- Ymax: `3`
- Refresh period: `10`

### Wykres wynikowy

**Charakterystyka i(t):**
```
i(t) [A]
 3 ┤                           _______________
   │                      ____/
 2 ┤                 ____/
   │            ____/
 1 ┤       ____/
   │  ____/
 0 └──┴────┴────┴────┴────┴────┴────┴────┴──→ t[s]
   0  1    2    3    4    5    6    7    8   10
```

**Interpretacja wykresu:**
- **Kształt:** Klasyczna charakterystyka narastania prądu w obwodzie RL
- **Wartość początkowa:** i(0) = 0 A
- **Wartość ustalona:** i(∞) = E/R = 5/2 = 2.5 A
- **Stała czasowa:** τ = L/R = 4/2 = 2 s
- **Czas narastania:** Po czasie ~5τ = 10s prąd osiąga 99% wartości ustalonej
- **Charakterystyka:** Wykładnicze narastanie zgodnie z: i(t) = (E/R) * (1 - e^(-t/τ))

**Fizyczna interpretacja:**
- Indukcyjność L opóźnia narastanie prądu
- Im większa L, tym wolniejszy wzrost prądu
- Im większa R, tym mniejszy prąd ustalony

## Przykład 1.02 - Modelowanie obwodu RC

### Schemat obwodu elektrycznego

Rozpatrzmy układ RC postaci:

```
        R
    o───────┬──o
    |   ic  |
  e(t)=E    C  uc
    |       |
    o───────┴──o
```

**Gdzie:**
- R - rezystancja [Ω]
- C - pojemność kondensatora [F]
- e(t) = E - źródło napięcia stałego [V]
- ic(t) - prąd ładowania kondensatora [A]
- uc(t) - napięcie na kondensatorze [V]

### Równanie obwodu

**Równanie według prawa Kirchhoffa:**
```
R * ic(t) + uc(t) = e(t)
```
gdzie `e(t) = E = const`

**Związek prądu i napięcia kondensatora:**
```
ic(t) = C * (duc(t)/dt)
```

**Podstawienie do równania obwodu:**
```
RC * (duc(t)/dt) + uc(t) = E
```

**Przekształcenie do postaci z pochodną:**
```
duc(t)/dt = (1/RC) * (E - uc(t))
```

**Warunek początkowy:**
```
uc(0) = 0  (kondensator rozładowany)
```

### Schemat blokowy w Xcos

**Implementacja w Xcos:**

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│              uc(0) = 0                                       │
│                  ↓                                           │
│  [E] → [Σ] → [1/(R*C)] → uc'(t) → [∫] → uc(t) → [Monitor]  │
│        - ↑                                  │                │
│          |                                  │                │
│          └──────────────────────────────────┘                │
│                                                              │
│  E=10; C=1; R=2                                             │
└──────────────────────────────────────────────────────────────┘
```

**Szczegółowy opis przepływu sygnałów:**

1. **[E]** - blok stałej (Constant) generuje napięcie zasilania E
2. **[Σ]** - sumator z wejściami:
   - Wejście górne (+): E
   - Wejście dolne (-): uc(t) (sprzężenie zwrotne)
   - Wyjście: E - uc(t)
3. **[1/(R*C)]** - wzmacniacz o wzmocnieniu 1/(R*C)
   - Wyjście: uc'(t) = (1/RC) * (E - uc(t))
4. **[∫]** - integrator z warunkiem początkowym uc(0) = 0
   - Wyjście: uc(t)
5. **Feedback** - bezpośrednie połączenie uc(t) → sumator
6. **[Monitor]** - wyświetlacz wykresu uc(t)

### Konfiguracja parametrów

**Ustaw kontekst (Widok → Ustaw kontekst):**
```scilab
E=10; C=1; R=2
```

**Parametry bloku CLOCK_c:**
- Okres: `0.01` [s]
- Initialisation Time: `0`

**Parametry bloku Scope:**
- Ymin: `0`
- Ymax: `12`
- Refresh period: `10`

### Wykres wynikowy

**Charakterystyka uc(t):**
```
uc(t) [V]
 10 ┤                         ___________________
    │                    ____/
  8 ┤                ___/
    │            ___/
  6 ┤        ___/
    │    ___/
  4 ┤ __/
    │/
  2 ┤
    │
  0 └──┴────┴────┴────┴────┴────┴────┴────┴──→ t[s]
    0  1    2    3    4    5    6    7    8   10
```

**Interpretacja wykresu:**
- **Kształt:** Klasyczna charakterystyka ładowania kondensatora
- **Wartość początkowa:** uc(0) = 0 V (kondensator rozładowany)
- **Wartość ustalona:** uc(∞) = E = 10 V
- **Stała czasowa:** τ = RC = 2 * 1 = 2 s
- **Czas ładowania:** Po czasie ~5τ = 10s napięcie osiąga 99% wartości E
- **Charakterystyka:** Wykładnicze narastanie zgodnie z: uc(t) = E * (1 - e^(-t/τ))

**Fizyczna interpretacja:**
- Kondensator stopniowo się ładuje przez rezystor R
- Im większa pojemność C, tym wolniejsze ładowanie
- Im większa rezystancja R, tym wolniejsze ładowanie
- Wartość ustalona zależy tylko od E (napięcia źródła)

**Porównanie z obwodem RL:**
- Oba układy mają podobną charakterystykę wykładniczą
- W RL narastał prąd, w RC narasta napięcie
- Stała czasowa: RL → τ = L/R, RC → τ = RC

---

## Dodatkowe przykłady użycia bloków Expression

### Blok Expression z jednym wejściem

**Przykład:** `y = w*w*sin(u1)`

```
┌────────────────────────────────────────────────┐
│ u1 ──→│ Expression :            │──→ y         │
│       │ w*w*sin(u1)             │              │
│       └─────────────────────────┘              │
│                                                │
│ Konfiguracja:                                 │
│ number of inputs    │ 1 │                     │
│ scilab expression   │ w*w*sin(u1) │           │
└────────────────────────────────────────────────┘
```

**Zastosowanie:**
- Definicja funkcji zdefiniowanej przez użytkownika
- u1 - pierwsza zmienna wejściowa
- w - parametr zdefiniowany w kontekście

### Blok Expression z dwoma wejściami

**Przykład:** `y = n*(1-b*b*sin(u1)^2)*u2`

```
┌────────────────────────────────────────────────────┐
│ u1 ──→│ Expression :                    │──→ y     │
│ u2 ──→│ n*(1-b*b*sin(u1)^2)*u2          │          │
│       └─────────────────────────────────┘          │
│                                                    │
│ Konfiguracja:                                     │
│ number of inputs    │ 2 │                         │
│ scilab expression   │ n*(1-b*b*sin(u1)^2)*u2 │    │
└────────────────────────────────────────────────────┘
```

**Zastosowanie:**
- Złożone funkcje wielu zmiennych
- u1, u2 - zmienne wejściowe
- n, b - parametry zdefiniowane w kontekście

### Blok SUPER_f (Podsystem)

**Struktura:**

```
┌─────────────────────────────────────────────────────┐
│ we1 ──→│         ┌──────────────┐         │──→ wy1  │
│ we2 ──→│  SUPER_f│  Podsystem   │         │         │
│        │         │ (wewnętrzny  │         │         │
│        │         │  schemat)    │         │         │
│        │         └──────────────┘         │         │
│                                                     │
│ Zawiera kompletny schemat blokowy wewnątrz         │
└─────────────────────────────────────────────────────┘
```

**Zastosowanie:**
- Hierarchiczna budowa modeli
- Grupowanie bloków w logiczne podsystemy
- Uproszczenie złożonych schematów
- Ponowne użycie fragmentów modelu

**Przykład użycia w praktyce:**
```
[Inputs] → [SUPER_f: Regulator PID] → [SUPER_f: Model obiektu] → [Output]
```

---

## Praktyczne wskazówki do pracy z Xcos

### Łączenie bloków
1. Kliknij na wyjście bloku źródłowego
2. Przeciągnij linię do wejścia bloku docelowego
3. Linia pojawi się w kolorze niebieskim (lub innym, zależnie od ustawień)

### Usuwanie połączeń
1. Kliknij na linię
2. Naciśnij klawisz `Delete` lub `Backspace`

### Kopiowanie bloków
1. Zaznacz blok
2. `Ctrl+C` (kopiuj), `Ctrl+V` (wklej)
3. Lub przeciągnij blok z przytrzymanym `Ctrl`

### Obracanie bloków
1. Zaznacz blok
2. Menu: `Format → Lustro` - odbicie poziome
3. Menu: `Format → Obrót` - obrót o 90°

### Zmiana rozmiaru bloków
1. Zaznacz blok
2. Przeciągnij za rogi lub krawędzie

### Dodawanie punktów węzłowych do linii
1. Kliknij prawym przyciskiem na linię
2. Wybierz "Add point"
3. Przeciągnij punkt węzłowy w nowe miejsce

### Debugowanie modelu
1. Sprawdź czy wszystkie bloki są poprawnie połączone
2. Sprawdź warunki początkowe w integratorach
3. Sprawdź znaki w sumatorach (+ lub -)
4. Sprawdź parametry w kontekście
5. Uruchom symulację i obserwuj komunikaty o błędach w konsoli

### Zapisywanie projektu
- `File → Save` lub `Ctrl+S`
- Rozszerzenie pliku: `.zcos`
- Nazwa pliku powinna być opisowa, np. `lab1_01-RL.zcos`

---

## Podsumowanie

### Kluczowe koncepcje
- **Scilab/Xcos** to darmowe narzędzie do modelowania i symulacji
- **Modele buduje się jako schematy blokowe** łącząc gotowe bloki
- **Równania różniczkowe rozwiązuje się poprzez łańcuchy bloków całkujących**
- **Warunki początkowe** ustawia się w parametrach bloków całkujących
- **Parametry można definiować w kontekście** używając instrukcji Scilab
- **Wyniki wizualizuje się za pomocą bloków monitora (Scope)**

### Typowy workflow
1. Zapisz równania różniczkowe opisujące system
2. Przekształć równania do postaci z pochodnymi najwyższego rzędu
3. Zbuduj schemat z łańcucha integratorów
4. Dodaj sprzężenia zwrotne zgodnie z równaniami
5. Ustaw parametry w kontekście
6. Skonfiguruj warunki początkowe
7. Ustaw czas symulacji i krok całkowania
8. Uruchom symulację
9. Analizuj wykresy

### Najczęstsze błędy
- **Niepoprawne znaki w sumatorze** - sprawdź czy znaki +/- odpowiadają równaniom
- **Brak warunków początkowych** - ustaw wartości początkowe w integratorach
- **Zbyt duży krok całkowania** - zmniejsz wartość "Okres" w bloku CLOCK_c
- **Źle ustawiony zakres wykresu** - dopasuj Ymin/Ymax w parametrach Scope
- **Brak definicji parametrów** - zdefiniuj wszystkie zmienne w kontekście
- **Pętle algebraiczne** - sprawdź czy nie ma bezpośrednich sprzężeń zwrotnych bez opóźnień
