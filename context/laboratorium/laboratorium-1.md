# Laboratorium 1 - Zapoznanie się z pakietem SciLab - Xcos

## Cel zajęć

Korzystając z materiałów zamieszczonych w wykładach opracować i uruchomić procesy opisane równaniami różniczkowymi dla stanów nieustalonych (przejściowych) w układach.

---

## Zadanie 1 - Modelowanie obwodu RL

### Schemat obwodu

```
        L       R
    o─────∩∩∩∩∩─────┬──o
    |                |
  e(t)             i(t)
    |                |
    o────────────────┴──o
```

### Równanie różniczkowe

```
L * (di(t)/dt) + R * i(t) = e(t)
```

**Warunki:**
- `e(t) = E = const` - napięcie stałe
- `i(0) = 0` - warunek początkowy (brak prądu początkowego)

### Zadanie

**Wyznaczyć przebieg i(t) dla:**
- **E = 5 [V]**
- **Czas obliczeń: 15 [s]**

### Warianty obliczeń

**Wykonać 6 symulacji dla różnych kombinacji R i L:**

| Nr | R [Ω] | L [H] | Oczekiwany efekt |
|----|-------|-------|------------------|
| 1  | 0.5   | 2     | Szybkie narastanie do wysokiej wartości |
| 2  | 0.5   | 10    | Wolniejsze narastanie do wysokiej wartości |
| 3  | 2.0   | 2     | Średnie narastanie do średniej wartości |
| 4  | 2.0   | 10    | Wolniejsze narastanie do średniej wartości |
| 5  | 5.0   | 2     | Średnie narastanie do niskiej wartości |
| 6  | 5.0   | 10    | Wolne narastanie do niskiej wartości |

### Analiza parametrów

**Wpływ rezystancji R:**
- R = 0.5 Ω → i(∞) = E/R = 5/0.5 = **10 A** (prąd ustalony największy)
- R = 2.0 Ω → i(∞) = E/R = 5/2.0 = **2.5 A** (prąd ustalony średni)
- R = 5.0 Ω → i(∞) = E/R = 5/5.0 = **1.0 A** (prąd ustalony najmniejszy)

**Wpływ indukcyjności L:**
- Stała czasowa: τ = L/R
- L = 2 H → szybsze narastanie (mniejsza stała czasowa)
- L = 10 H → wolniejsze narastanie (większa stała czasowa)

### Przykładowe stałe czasowe

| R [Ω] | L [H] | τ = L/R [s] | Czas ustalania (~5τ) |
|-------|-------|-------------|----------------------|
| 0.5   | 2     | 4           | 20 s                 |
| 0.5   | 10    | 20          | 100 s                |
| 2.0   | 2     | 1           | 5 s                  |
| 2.0   | 10    | 5           | 25 s                 |
| 5.0   | 2     | 0.4         | 2 s                  |
| 5.0   | 10    | 2           | 10 s                 |

### Implementacja w Xcos

**Model zgodny z wykładem 1.01:**

```
[E] → [Σ] → [1/L] → i'(t) → [∫] → i(t) → [Monitor]
      - ↑                   i(0)=0
        |
        └────[R]←───────────┘
```

**Konfiguracja kontekstu (przykład dla pierwszego wariantu):**
```scilab
E=5; L=2; R=0.5
```

**Parametry symulacji:**
- Ostateczny czas integracji: `15`
- Okres (CLOCK_c): `0.01`
- Initialisation Time: `0`

**Parametry monitora:**
- Ymin: `0`
- Ymax: `12` (dla R=0.5), `3` (dla R=2.0), `1.5` (dla R=5.0)
- Refresh period: `15`

### Zadania do wykonania

1. **Zbuduj model** w Xcos zgodnie ze schematem z wykładu 1.01
2. **Dla każdej kombinacji R i L:**
   - Zaktualizuj parametry w kontekście
   - Uruchom symulację
   - Zapisz wykres (File → Export)
   - Zanotuj wartość ustaloną prądu
3. **Porównaj wykresy** dla różnych wartości:
   - Jak zmienia się prąd ustalony przy zmianie R?
   - Jak zmienia się szybkość narastania przy zmianie L?
4. **Sprawdź zgodność** z teorią:
   - Czy i(∞) ≈ E/R?
   - Czy czas narastania jest proporcjonalny do L/R?

### Wskazówki

- **Zapisz model** dla pierwszego wariantu jako `lab1_RL_R05_L2.zcos`
- **Kopiuj model** i zmieniaj tylko parametry dla kolejnych wariantów
- **Nazewnictwo plików:** `lab1_RL_R[wartość]_L[wartość].zcos`
- **Eksportuj wykresy** jako obrazy PNG do dokumentacji

---

## Zadanie 2 - Modelowanie obwodu RC

### Schemat obwodu

```
        R
    o───────┬──o
    |   ic  |
  e(t)=E    C  uc
    |       |
    o───────┴──o
```

### Równania

**Równanie obwodu:**
```
R * ic(t) + uc(t) = e(t)
```

**Związek prądu i napięcia kondensatora:**
```
ic(t) = C * (duc(t)/dt)
```

**Warunki:**
- `e(t) = E = const` - napięcie stałe
- `uc(0) = 0` - warunek początkowy (kondensator rozładowany)

### Zadanie

**Wyznaczyć przebiegi ic(t) oraz uc(t) dla:**
- **E = 10 [V]**
- **Czas obliczeń: 15 [s]**

### Warianty obliczeń

**Wykonać 6 symulacji dla różnych kombinacji R i C:**

| Nr | R [Ω] | C [F] | Oczekiwany efekt |
|----|-------|-------|------------------|
| 1  | 0.5   | 2     | Szybkie ładowanie, mała stała czasowa |
| 2  | 0.5   | 10    | Wolniejsze ładowanie, większa stała czasowa |
| 3  | 2.0   | 2     | Średnie ładowanie |
| 4  | 2.0   | 10    | Średnie ładowanie, wolniejsze |
| 5  | 5.0   | 2     | Wolniejsze ładowanie |
| 6  | 5.0   | 10    | Najwolniejsze ładowanie |

### Analiza parametrów

**Napięcie na kondensatorze:**
- Dla wszystkich wariantów: **uc(∞) = E = 10 V**
- Wartość ustalona nie zależy od R i C

**Prąd początkowy kondensatora:**
- ic(0) = E/R
- R = 0.5 Ω → ic(0) = 10/0.5 = **20 A**
- R = 2.0 Ω → ic(0) = 10/2.0 = **5 A**
- R = 5.0 Ω → ic(0) = 10/5.0 = **2 A**

**Prąd ustalony:**
- ic(∞) = 0 A (kondensator w pełni naładowany, brak przepływu prądu)

**Stała czasowa:**
- τ = RC

### Przykładowe stałe czasowe

| R [Ω] | C [F] | τ = RC [s] | Czas ustalania (~5τ) |
|-------|-------|------------|----------------------|
| 0.5   | 2     | 1          | 5 s                  |
| 0.5   | 10    | 5          | 25 s                 |
| 2.0   | 2     | 4          | 20 s                 |
| 2.0   | 10    | 20         | 100 s                |
| 5.0   | 2     | 10         | 50 s                 |
| 5.0   | 10    | 50         | 250 s                |

### Implementacja w Xcos

**Model dla napięcia uc(t) - zgodny z wykładem 1.02:**

```
[E] → [Σ] → [1/(R*C)] → uc'(t) → [∫] → uc(t) → [Monitor]
      - ↑                       uc(0)=0
        |
        └───────────────────────────┘
```

**Model dla prądu ic(t):**

Opcja 1 - używając bloku DERIV (pochodna):
```
uc(t) → [DERIV] → duc/dt → [C] → ic(t) → [Monitor]
```

Opcja 2 - używając relacji ic = C * duc/dt bezpośrednio w modelu:
```
uc'(t) → [C] → ic(t) → [Monitor]
```

**Zalecenie:** Użyj **dwóch monitorów** - jeden dla uc(t), drugi dla ic(t)

**Konfiguracja kontekstu (przykład dla pierwszego wariantu):**
```scilab
E=10; C=2; R=0.5
```

**Parametry symulacji:**
- Ostateczny czas integracji: `15`
- Okres (CLOCK_c): `0.01`
- Initialisation Time: `0`

**Parametry monitora dla uc(t):**
- Ymin: `0`
- Ymax: `12`
- Refresh period: `15`

**Parametry monitora dla ic(t):**
- Ymin: `0`
- Ymax: `25` (dla R=0.5), `6` (dla R=2.0), `3` (dla R=5.0)
- Refresh period: `15`

### Zadania do wykonania

1. **Zbuduj model** w Xcos z dwoma monitorami:
   - Monitor 1: napięcie uc(t)
   - Monitor 2: prąd ic(t)
2. **Dla każdej kombinacji R i C:**
   - Zaktualizuj parametry w kontekście
   - Uruchom symulację
   - Zapisz oba wykresy
   - Zanotuj wartości początkowe i ustalone
3. **Zaobserwuj zależności:**
   - Jak zmienia się prąd początkowy ic(0) przy zmianie R?
   - Jak zmienia się szybkość ładowania przy zmianie C?
   - Czy napięcie ustalone zawsze osiąga wartość E?
4. **Porównaj charakterystyki:**
   - uc(t) - narastanie do E
   - ic(t) - spadek od E/R do 0

### Wskazówki

- **Zapisz model** jako `lab1_RC_R[wartość]_C[wartość].zcos`
- **Użyj monitora dwustrumieniowego** (z wykładu 2) aby wyświetlić oba przebiegi na jednym wykresie
- **Parametry monitora dwustrumieniowego:**
  ```
  Input ports sizes: 1 1
  Ymin vector: 0 0
  Ymax vector: 12 25  (dostosuj do wartości)
  Refresh period: 15 15
  Drawing colors: 5 1 5 7 9 11 13 15
  ```
- **Eksportuj wykresy** dla dokumentacji

---

## Uwagi praktyczne

### Organizacja pracy

1. **Struktura folderów:**
   ```
   lab1/
   ├── RL/
   │   ├── lab1_RL_R05_L2.zcos
   │   ├── lab1_RL_R05_L10.zcos
   │   ├── ...
   │   └── wykresy/
   └── RC/
       ├── lab1_RC_R05_C2.zcos
       ├── lab1_RC_R05_C10.zcos
       ├── ...
       └── wykresy/
   ```

2. **Systematyka nazewnictwa:**
   - Model: `lab1_[typ]_R[wartość]_[L/C][wartość].zcos`
   - Wykres: `wykres_[typ]_R[wartość]_[L/C][wartość].png`

3. **Dokumentacja wyników:**
   - Sporządź tabelę z wartościami teoretycznymi i zmierzonymi
   - Porównaj wartości ustalone z teoretycznymi (E/R dla RL, E dla RC)
   - Porównaj czasy narastania z teoretycznymi (~5τ)

### Weryfikacja wyników

**Dla obwodu RL:**
- [ ] Prąd ustalony i(∞) zgadza się z E/R (tolerancja ±5%)
- [ ] Czas narastania jest proporcjonalny do L/R
- [ ] Dla większego L narastanie jest wolniejsze
- [ ] Dla większego R prąd ustalony jest mniejszy

**Dla obwodu RC:**
- [ ] Napięcie ustalone uc(∞) = E dla wszystkich wariantów
- [ ] Prąd początkowy ic(0) = E/R
- [ ] Prąd ustalony ic(∞) = 0 dla wszystkich wariantów
- [ ] Czas ładowania jest proporcjonalny do RC
- [ ] Dla większego C ładowanie jest wolniejsze

### Typowe problemy i rozwiązania

**Problem:** Wykres nie mieści się w oknie monitora
- **Rozwiązanie:** Użyj ikony LUPKI (🔍) aby dopasować wykres

**Problem:** Symulacja trwa bardzo długo
- **Rozwiązanie:** Zmniejsz czas symulacji lub zwiększ krok całkowania (ostrożnie!)

**Problem:** Nieprawidłowe wartości ustalone
- **Rozwiązanie:** Sprawdź:
  - Parametry w kontekście (czy są poprawnie zdefiniowane?)
  - Warunki początkowe w integratorach
  - Znaki w sumatorze
  - Wzmocnienia bloków

**Problem:** Wykres ic(t) nie zaczyna się od prawidłowej wartości
- **Rozwiązanie:** Upewnij się, że ic(t) jest obliczane jako C * duc/dt, a nie z integratora

---

## Podsumowanie laboratorium

Po wykonaniu laboratorium powinieneś:

1. **Umieć budować** modele symulacyjne dla układów RL i RC w Xcos
2. **Rozumieć wpływ** parametrów R, L, C na:
   - Wartości ustalone
   - Szybkość narastania/opadania sygnałów
   - Stałe czasowe układów
3. **Potrafić analizować** wykresy przebiegów czasowych
4. **Weryfikować wyniki** symulacji z obliczeniami teoretycznymi
5. **Organizować pracę** z wieloma wariantami symulacji

### Przygotowanie do sprawozdania

**Sprawozdanie powinno zawierać:**
1. Schematy bloków dla obu układów (RL i RC)
2. Wykresy dla wszystkich 12 wariantów (6 dla RL + 6 dla RC)
3. Tabelę z wynikami teoretycznymi i zmierzonymi
4. Analizę zgodności wyników z teorią
5. Wnioski dotyczące wpływu parametrów na charakterystyki układów

**Format sprawozdania** - szczegóły na stronie: www.jan.makuch.eu (zakładka "Zaliczenie przedmiotu")
