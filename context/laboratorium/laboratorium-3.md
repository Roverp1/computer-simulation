# Laboratorium 3 - Modele symulacyjne

**Temat:** Modelowanie i symulacja komputerowa - Modele symulacyjne

---

## Cel ćwiczenia

Korzystając z materiałów zamieszczonych w wykładach opracować i uruchomić procesy opisane równaniami różniczkowymi dla stanów nieustalonych (przejściowych) w układach.

---

## Zadanie - Układ dwóch równań różniczkowych

### Dany układ równań różniczkowych

```
dy/dt + y + 3x = 0

d²x/dt² + 0.8(dx/dt) - 0.3y + 0.2x = 0
```

### Warunki początkowe

```
y(0) = 0
x(0) = 5/3
x'(0) = 0.6 + 7/2
```

**Obliczenia wartości początkowych:**
```
x(0) = 5/3 ≈ 1.667
x'(0) = 0.6 + 3.5 = 4.1
```

---

## Polecenia

### 1. Model symulacyjny

Sporządzić model symulacyjny zgodny z zadanym układem równań różniczkowych i warunkami początkowymi.

### 2. Parametry symulacji

**Krok obliczeniowy:**
```
h = 0.01 [s]
```

**Czas obliczeń:**
```
Tkon = 40 [s]
```

### 3. Wykresy do sporządzenia

**a) Wykres x(t) oraz x'(t):**
- Monitor dwustrumieniowy (dwukanałowy oscyloskop)
- Wyświetlenie obu przebiegów na jednym wykresie

**b) Wykres y(t) oraz y'(t):**
- Monitor dwustrumieniowy (dwukanałowy oscyloskop)
- Wyświetlenie obu przebiegów na jednym wykresie

**c) Portret fazowy:**
- Wykres x' w funkcji x
- Reprezentacja fazowa układu dynamicznego

### 4. Warianty modelu

Sporządzić dwa warianty modelu:
1. **Bez bloku Expression** - implementacja z użyciem podstawowych bloków Xcos
2. **Z blokiem Expression** - implementacja z wykorzystaniem bloku Expression do definicji funkcji

---

## Przekształcenie równań do postaci normalnej

### Równanie 1 (dla y)

**Równanie wyjściowe:**
```
dy/dt + y + 3x = 0
```

**Postać normalna:**
```
dy/dt = -y - 3x
```

**Sprzężenia:**
- Wymaga sygnału y (sprzężenie zwrotne)
- Wymaga sygnału x (sprzężenie z drugiego równania)

### Równanie 2 (dla x)

**Równanie wyjściowe:**
```
d²x/dt² + 0.8(dx/dt) - 0.3y + 0.2x = 0
```

**Postać normalna:**
```
d²x/dt² = -0.8(dx/dt) + 0.3y - 0.2x
```

lub

```
x'' = -0.8x' + 0.3y - 0.2x
```

**Sprzężenia:**
- Wymaga sygnału x' (sprzężenie zwrotne od pierwszego integratora)
- Wymaga sygnału x (sprzężenie zwrotne od drugiego integratora)
- Wymaga sygnału y (sprzężenie z pierwszego równania)

---

## Struktura modelu symulacyjnego

### Wariant 1 - Bez bloku Expression

#### Równanie dla y (dy/dt = -y - 3x)

```
[Σ] → [∫] → y
 ↑     │
 │     │ (sprzężenie zwrotne)
 │     └──[*(-1)]──┐
 │                 ↓
 │                [Σ]
 │                 ↑
 └──[*(-3)]←[x]────┘
```

**Struktura:**
- Sumator z dwoma wejściami
- Integrator z warunkiem początkowym y(0) = 0
- Wzmacniacz -1 dla sprzężenia zwrotnego y
- Wzmacniacz -3 dla sygnału x

#### Równanie dla x (x'' = -0.8x' + 0.3y - 0.2x)

```
[Σ] → [∫] → [∫] → x
 ↑     │x''  │x'
 │     │     │
 ├─[*(-0.8)]←┤ (sprzężenie od x')
 │           │
 ├─[*0.3]←[y]│ (sprzężenie od y)
 │           │
 └─[*(-0.2)]←┘ (sprzężenie od x)
```

**Struktura:**
- Sumator z trzema wejściami
- Pierwszy integrator: x'' → x', warunek początkowy x'(0) = 4.1
- Drugi integrator: x' → x, warunek początkowy x(0) = 5/3
- Wzmacniacz -0.8 dla sprzężenia x'
- Wzmacniacz 0.3 dla sprzężenia y
- Wzmacniacz -0.2 dla sprzężenia x

### Wariant 2 - Z blokiem Expression

**Dla równania y:**

Blok Expression może zawierać funkcję:
```
-u1 - 3*u2
```
gdzie:
- u1 = y (sprzężenie zwrotne)
- u2 = x (sprzężenie z drugiego równania)

**Dla równania x:**

Blok Expression może zawierać funkcję:
```
-0.8*u1 + 0.3*u2 - 0.2*u3
```
gdzie:
- u1 = x' (sprzężenie zwrotne od pierwszego integratora)
- u2 = y (sprzężenie z pierwszego równania)
- u3 = x (sprzężenie zwrotne od drugiego integratora)

---

## Bloki Xcos do wykorzystania

### Bloki podstawowe

1. **Integrator (INTEGRAL_m)**
   - Parametry: warunek początkowy
   - Dla y: y(0) = 0
   - Dla x': x'(0) = 4.1
   - Dla x: x(0) = 5/3

2. **Sumator (SUMMATION)**
   - Parametr: znaki wejść (np. [1; 1; 1] lub [1; -1])

3. **Wzmacniacz (GAINBLK_f)**
   - Parametry: współczynniki wzmocnienia
   - -1, -3 (dla równania y)
   - -0.8, 0.3, -0.2 (dla równania x)

4. **Multiplekser (MUX)**
   - Do łączenia sygnałów dla oscyloskopu dwustrumieniowego

5. **Oscyloskop (CSCOPE)**
   - Monitor dwustrumieniowy dla x(t) i x'(t)
   - Monitor dwustrumieniowy dla y(t) i y'(t)

6. **XY Oscyloskop (CSCOPE)**
   - Dla portretu fazowego x' = f(x)
   - Wejście X: x
   - Wejście Y: x'

### Bloki specjalne (dla Wariantu 2)

7. **Expression (EXPRESSION)**
   - Definicja funkcji matematycznych
   - Wejścia: u1, u2, u3, ...
   - Wyjście: wynik wyrażenia

---

## Parametry symulacji

### Setup → Simulation

**Final integration time:**
```
Tkon = 40
```

**Realtime scaling:**
```
0 (wyłączone)
```

**Solver:**
```
Max step size: 0.01 (h = 0.01 s)
```

**Solver type:**
```
Zalecany: ode45 (Dormand-Prince) lub podobny
```

---

## Oczekiwane wyniki

### Wykres x(t) i x'(t)

**Charakterystyka:**
- Warunek początkowy x(0) = 5/3 ≈ 1.667
- Warunek początkowy x'(0) = 4.1
- Spodziewane oscylacje tłumione (ze względu na człon tłumiący 0.8x')
- Czas obserwacji: t ∈ [0, 40] [s]

### Wykres y(t) i y'(t)

**Charakterystyka:**
- Warunek początkowy y(0) = 0
- Spodziewane oscylacje związane ze sprzężeniem z x
- Czas obserwacji: t ∈ [0, 40] [s]

### Portret fazowy x' = f(x)

**Charakterystyka:**
- Punkt startowy: (x(0), x'(0)) = (5/3, 4.1)
- Trajektoria fazowa pokazująca ewolucję układu
- Zbieżność do punktu równowagi lub oscylacje graniczne
- Spirala lub zamknięta krzywa w zależności od charakteru układu

---

## Wskazówki implementacyjne

### Kolejność budowy modelu

1. **Zidentyfikować zmienne stanu:**
   - y, x, x'

2. **Zbudować równanie dla y:**
   - Integrator dla dy/dt → y
   - Sumator dla wyrażenia -y - 3x
   - Sprzężenia zwrotne

3. **Zbudować równanie dla x:**
   - Dwa integratory: x'' → x' → x
   - Sumator dla wyrażenia -0.8x' + 0.3y - 0.2x
   - Sprzężenia zwrotne i krzyżowe

4. **Połączyć sprzężenia:**
   - y → równanie dla x (współczynnik 0.3)
   - x → równanie dla y (współczynnik -3)

5. **Dodać instrumentację:**
   - MUX + Scope dla x i x'
   - MUX + Scope dla y i y'
   - XY Scope dla portretu fazowego

### Sprawdzenie poprawności

**Weryfikacja warunków początkowych:**
- Sprawdzić czy integratory mają poprawnie ustawione warunki początkowe
- y(0) = 0
- x(0) = 5/3
- x'(0) = 4.1

**Weryfikacja współczynników:**
- Sprawdzić znaki we wszystkich sprzężeniach zwrotnych
- Sprawdzić wartości współczynników wzmocnienia

**Weryfikacja czasu symulacji:**
- h = 0.01 s (krok)
- Tkon = 40 s (czas końcowy)

---

## Analiza wyników

### Co obserwować

1. **Stabilność układu:**
   - Czy zmienne dążą do wartości ustalonej?
   - Czy występują oscylacje? (tłumione/nietłumione)

2. **Wpływ sprzężeń:**
   - Jak zmiany w x wpływają na y i odwrotnie
   - Rola członu tłumiącego 0.8x'

3. **Portret fazowy:**
   - Typ trajektorii (spirala, ognisko, węzeł)
   - Punkt równowagi układu

4. **Porównanie wariantów:**
   - Czy wyniki z Wariantu 1 i 2 są identyczne?
   - Która implementacja jest prostsza?

---

## Uwagi dodatkowe

### Obliczenia algebraiczne dla warunków początkowych

**Wartość x(0):**
```
x(0) = 5/3 = 1.666666...
```

**Wartość x'(0):**
```
x'(0) = 0.6 + 7/2 = 0.6 + 3.5 = 4.1
```

### Rodzaj układu

Układ dwóch sprzężonych równań różniczkowych:
- Równanie I rzędu dla y
- Równanie II rzędu dla x
- Całkowity rząd układu: 3 (trzy zmienne stanu: y, x, x')

### Zastosowania

Takie układy mogą modelować:
- Sprzężone układy mechaniczne (masa-sprężyna-tłumik)
- Układy elektryczne (obwody RLC)
- Układy elektromechaniczne
- Regulatory automatyki

---

## Podsumowanie zadania

**Zadanie polega na:**

1. Przekształceniu układu równań do postaci normalnej
2. Zbudowaniu modelu symulacyjnego w Xcos (dwa warianty)
3. Przeprowadzeniu symulacji z zadanymi parametrami
4. Sporządzeniu wykresów czasowych i portretu fazowego
5. Analizie wyników i zachowania układu dynamicznego

**Kluczowe umiejętności:**
- Przekształcanie równań różniczkowych
- Implementacja sprzężeń zwrotnych i krzyżowych
- Ustawianie warunków początkowych
- Konfiguracja parametrów symulacji
- Wizualizacja wyników (wykresy czasowe i fazowe)
