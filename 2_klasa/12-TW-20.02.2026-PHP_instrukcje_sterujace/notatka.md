# INSTRUKCJE STERUJĄCE

## Instrukcje warunkowe
```PHP
    if(warunek){
        kod;
    }
```

```PHP
    if(warunek){
        kod
    }
    else{
        kod
    }
```

```PHP
    if(warunek){
        kod
    }
    else if(warunek){
        kod
    }
    else if(warunek){
        kod
    }
    else{
        kod
    }
```

### ZADANIE:
```PHP
    $liczba=(integer) 8.0;

    if($liczba > 0.0){
        echo "Podana licba jest większa od zera";
    else if($liczba == 0.0){
        echo "Podana liczba jest równa 0";
    }
    else if ($liczba < 0.0){
        echo "Podana liczba jest mniejsza od zera";
    }
    else{
        echo "Nie poprawna liczba"
    }
```

## Operator warunkowy

```PHP
//          true       false
warunek ? wartosc1 : wartosc 2;
```

```PHP
    $x=1;
    $wynik=($x<0) ? "ujemna" : "dodatnia";
    echo "$x to $wynik";
```

[20.02.2026] Kontynuacja notatki

## Pętle

for:
```PHP
    for(wyr_początkowe; wyr_warunkowe; wyr_modyfikujące){
        rób coś;
    }
```

### ZADANIE 2:
```PHP
    for(int i = 1000; i > 0; i--){
        echo "$i\n";
    }
```

#### while:
```PHP
    while(warunek){
        rób coś;
    }
```
#### do:
```PHP
    do{
        rób coś;
    }
    while(warunek);
```

#### foreach:
```PHP
    foreach($tablica as $wartosc){
        rób coś;
    }
```
lub
```PHP
    foreach($tablica as $klucz => $wartosc){
        rób coś;
    }
```

### ZADANIE 3:
```PHP
    $tablica = [13, 25, 36];

    foreach($tablica as $i => $val){
        echo "wyraz $i wynosi $val";
    }
```

### ZADANIE 4:
```PHP
    for($i = 30; $i > 0; $i--){
        if($i % 2 == 1){
            echo "$i\n";
        }
    }
```

### ZADANIE 5:
```PHP
    $przedmioty = ["Polski", "Angielski", "Niemiecki", "Informatyka", "Gruziński"];
    $oceny = [4, 5, 3, 6, 5];
    
    echo "OCENY: \n";
    foreach($przedmioty as $i => $przedmiot){
        echo " [$przedmiot -> $oceny[$i]]\n";
    }
```

## FUNKCJE

Funkcja - to ciąg instrukcji stanowiący blok kodu, który może być wielkrotnie wykorzystany. Za każdym razem funkcja może być wywołana z różnymi argumentami.

```PHP
    function nazwa($arg1, $arg2, ...){
        rób coś;
    }
```
### Przykład:
```PHP
    function dodaj($a, $b){
        $c = $a + $b;
        echo "wynik dodawania $a oraz $b to $c";
    }

    dodaj(-32, 14);
```

### Zwracanie wartosci:
    return - używamy w celu zwrotu wartości do bloku kodu
```PHP
    function nawzwa($arg1, $arg2, ...){
        $wartosc = coś;
        rób coś;
        return $wartosc;
    }
```
### Przykład:

```PHP
    function dodaj($a, $b){
        return $a + $b;
    }

    $n1 = 125;
    $n2 = -4251;
    echo "wynik dodawania $n1 oraz $n2 to: " . dodaj($n1, $n2);
```

## Zasięg Zmiennych:
* Globalna - widoczna w całym skrypcie. Zdefiniowana poza funkcją. Można z niej korzystać w każdym miejscu skrytpu z wyjątkiem wnętrza funckji.
* Lokalna - ma zasięg lokalny i jest definiowana wewnątrz funkcji. Ich zasięg dotyczy funkcji, poza nią nie są widoczne.

## Zmienne globalne
```PHP
    $ZMNIENNA=1;
    function test(){
        echo $ZMIENNA;
    }
    test();
```

## Instrukcja global:
```PHP
    $ZMIENNA = 1;
    function test(){
        global $ZMIENNA;
        echo "$ZMIENNA"
    }

    test();
```

## Zmienne statyczne:

Służą do zachownia wartości pomiędzy kolejnymi wywoływaniami funkcji.

### Przykład:

```PHP    
    function test(){
        static $i=1;
        echo "Funkcja wywołana ".$i." raz(y)<br/>";
        $i++;
   }

   test();
   test();
   test();
```

### Argumenty funkcji:

Wartość - do funkcji przekazywane są kapioe argumentów źródłowch i wszstkie kopie są wykonane na kopiach.

Referencji - funkcja modyfikuje argumenty oryginalne. W takim przypadku przed przekazywanym argumentem trzeba zamieścić '&'.

Przykład:

```PHP
    function nazwa($arg1 = var; $arg2 = var;){
        rób coś;
    }
```

## Funkcje wbudowane:

Funkcje tablic:
* count()
* sizeof()

Funkcje sortowania:
* sort() - sortuje elementy TI w kolejności od najm. do najw.
* rsort() - sortuje elementy TI w koljeności od najw. do najm.
* asort() - sortuje elementy TA w kolejności id najm. do najw
* arsort() - sortuje elementy TA w kolejności od najw. do najm.
* ksort() - sortuje elementy TA wg. klucza w kolejności od najm. do najw.
* krsort() - sortuje elemety TA wg. klucza w kolejności od najw. do najm.

TI - tablica indeksowana
TA - tablica asocjacyjna

### Zadanie 1:
```PHP
    $tab = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    echo "\$tab ma ".count($tab)." elementów";
```
## Funkcja wyszukiwania:

array_search() - funkcja posiada dwa arguemty. Pierszwy to jest wartość poszukiwana, a drugi to przeszukiwana tablica. Jeżeli szukana wartość zostanie odnaleziona, zwróci true, a jeżeli nie to false;

## Zadanie 2:
```PHP
    $tab = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 15, 17];
    $parz = 0;
    $n_parz = 0;

    for($i = 0; $i < count($tab); $i++){
        if($tab[$i] % 2 == 0){
            $parz++;
        }
        else {
            $n_parz++;
        }
    }

    echo "W tablicy \$tab jest $parz liczb parzystych oraz $n_parz nie parzystych";
```

## Funkcje daty i czasu:
* time()
* getdate()
* date()
* mktime()

## Funkccja getdate([znacznik_czasu])
| Nazwa indeksu | Znaczenie            |
|---------------|----------------------|
| seconds | Liczba sekund |
| minutes | Liczba minut |
| hours | Liczba godzin |
| mday | Dzień miesiąca |
| wday | Dzień tygodnia |
| mon | Miesiąc jako liczba |
| year | Rok w postaci czterocyfrowej |
| yday | Numer kolejnego dnia roku |
| weekday | Dzień tygodnia |
| month | Miesiąc |

### Przykład:
```PHP
    $data = getdate();
    $dzien = $data["mday"];
    $miesiac=$data["mon"];
    $echo "Bieżąca data: $dzien-$miesiac"
```

## Funkcja date(format[znacznik_czasu])
| Znacznik | Znaczenie                                                     |
|:--------:|:--------------------------------------------------------------|
| a | Użycie określenia am lub pm|
| A | Użycie określenie AM lub PM |
| c | Data i czas zgodnie z ISO 8601 (2016-06-01 15:24:30) |
| d | Dzień miesiąca w foramcie z zerem na początku |
| D | Dzień tygodnia w formacie trzyliterowego skrótu Mon, Tue |
| F | Pełna nazwa miesiąca |
| g | Godzina w formacie dwunastogodzinnym bez zera na początku |
| G | Godzina w formaice dwudziesocztero godzinnym bez zera na początku |
| H | Godzina w formacie dwudziestoczterogodzinnym z zerem na początku |
| i | Liczba minut z zerem na początku |
| I | nazwa dnia tygododnia |
| m | Mieisąc w postaci liczby dwu cyfrowej z zerem na początku |
| s | liczba sekund z zerem na początku |
| Y | Rok w postaci czterech znaków |

### Przykład
```PHP
    echo date("Y-m-d G:i:s");
```

[06.03.2026] Kontynuacja notatki

## Funkcja mktime()
Funkcja mktime zwraca wynik czasu daty podanej jako argument funkcji. Może posiadadać sześć argumentów
* godzina
* minuta
* sekunda
* miesiąc
* dzień miesiąca
* rok

## Przykład:
```PHP
    $czas = mktime(22, 45, 0, 31, 12, 2015);
    echo "d-m-Y G:i, $czas)";
    echo "Y-m-d G:i:s, $czas)";
```

## Zadanie 1:
```PHP
    $data=getdate();
    $miesiace=["Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"];
    echo $data['mday']. " " . $miesiace[$data['mon'] - 1]. " " .$data['year'];
```

## Zadanie 2:
```PHP
    $data=getdate();
    $dni=["Poniedziałek","Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"];
    echo "Dzisiaj jest \"" . $dni[$data['wday'] - 1] . "\"";
```

## Zadanie 3:
```PHP
    $rok_st = mktime(0, 0, 0, 1, 1, 2026);
    $rok_kn = mktime(23, 59, 59, 12, 31, 2026);
    $teraz = time();
    
    $dni_up = floor(($teraz - $rok_st) / 86400);
    $dni_poz = floor(($rok_kn - $teraz ) / 86400);

    echo "Od początku roku upłyneło: " . $dni_up . " dni";
    echo "\n";
    echo "Do końca roku pozostało: " . $dni_poz. " dni";
```