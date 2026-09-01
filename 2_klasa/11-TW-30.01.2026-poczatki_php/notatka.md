# PHP
(ang. Hypettext Preprocessor) - wprowadzenie

## Definicja:
PHP jest językiem skryptowym działający po stronie serwera. Na stronie HTML można osadzić kod PHP która zostanie wykonany ilekroć strona jest odwiedzana.

-------

## Znaczniki bloku
standarodowy : <?php ... ?>
skrócony: <? ... ?>
ASP: <% ... %>
skryptwy: <script language="php"> ... </script>

## Test działania
```PHP
<?php
    echo "tekst PHP";
?>
```

-------

## Komentarze
```PHP
/* Blokowy */
// Jednowierszowy
# Jednowierzowy uniksowy
```

-------

## Zmienne
* Musi zaczynać się od litery lub znaku podkreślenia
* Może składać się z liter cyfr i znaku podkreśleinia
* Case-sensetive

## Zmienne globalne
* _GET - jet to tablica zawierająca zmienne przesyłane do skrypu za pomocą metody GET
* _POST - tablica do metody POST
* _COOKIE - tablica zmiennych przekazywanych z serwera do skrypu za pomocą cookies
* _FILES - tablica zawierająca zamienne przeazywane do skryptu podczas przysłania plików do serwera
* _SERVER - tablica zmiennych przekazywanych do skryptu przez server www(wersja serwera, ścieżka do pliku, adres skryptu ) adres skryptu, wysłane nagłówki
* _ENV - tablica zmiennych środowiskowych serwera
* _REQUEST - tablica zawierająca zmienne przeazkywane do skryput przez użytkownika
* _SESSION - tablica zawierająca zmienne zarejestrowane w bieżącej sesji
* _GLOBALS - tablica zawirająca odniesienie do kążdej zmiennej utworzonej przez użytkownika, która ma zasięg globalny dla danego skryptu

## Zapis zmiennych:
```PHP
    $_nazwa //styl krótki
    $_POST['nazwa'] //styl średni
    $HTTP_POST_VARS['nazwa'] //styl długi
```

## Typy Zmiennych
* skalarne:
    * boolean
    * integer
    * float/double
    * string

* zlożone:
    * array
    * object

* specjalne:
    * resource
    * null

```PHP
    // automatyczne przypisanie
    $tab=array(t1, t2 ... tn);

    // ręczne przypisanie
    $tab[0] = t1;
    $tab[1] = t2;
    $tab[n] = tn;
```

```PHP
    $tab=array(
        array("marka"=>"audi",
              "model"=>"a4"
              "wersja"=>"combi"),
        array("marka"=>"audi",
              "model"=>"a6"
              "wersja"=>"combi"),
        array("marka"=>"audi",
              "model"=>"a8"
              "wersja"=>"combi")
    );

    echo $tab[I]["model"];
```

## Typy rzutowania:
* integer - rzutowanie do typu całkowitego
* float (double) - typ rezczywisty
* String - ciąg tekstowy
* Array - rzutowanie do tablicy
* Object - rzutowanie do obiektu

```PHP
    $x=13.89;
    $y=(integer) $x;
    echo "$x";
    echo "<br>";
    echo "$y";
```

```
    $x=14;
    $y=(double) $x;
    $z="$x";
    echo "$x";
    echo "$y";
    ehco "$z";
```

## Operatory porówniania:

TODO


## Operatory bitowy:
* & - AND iloczny bitowy (
* | - OR suma bitowa
* ~ - NOT negacja bitowa
* ^ - XOR różnica symetrzyczna bitowa
* >> - przesunięcie biotowe w prawo
* << - przesunięcie bitowe w lewo

## Operatory logiczne:
* and - iloczyn logiczny
* && - ^

* or - suma logiczna
* || - ^

* ! - negacja 
* XOR - różnica symetryczna

## Operatory przypisania:
* =
* +=
* -=
* *=
* /=
* %=
* .= - operator kontkatencji Dodawanie stringa do tekstu

## in i de krementacja
* ++$x;
* $x++

* --$x
* $x--

## Deklaracja stałych:
* Zapisywanie DUŻYMI LITERAMI
* Zasięg globalny, można się odwałoąć z każdego miejsca sktypyu
* -> define("NAZWA-STALEJ", wartosc);

```PHP 
    define("CENA_K", 500);
    echo "cena koła: " .CENA_K;
```

## Stałe predifiniowane:
* TRUE - logiczna wartość prawda
* FALSE - logiczna wartość fałsz
* FILE - nazwa pliku ze skryptem który jest aktualnie przetwarzany
* LINE - stała zawierająca numer linii w skrypcie który jest aktualnie przetwarzany
* DIR - stała zawierająca nazwę katalogu pliku
* FUNCTION - stała zawierająca nazwę funkcji
* CLASS - stała zawierająca nazwę klasy
* METHOD - stałą zawierająca nazwę metody

```PHP
define("PI", 3.141592);

$promien=fopen( 'php://stdin', 'r' );

while( $line = fgets( $promien ) ) {
  echo $line;
}
fclose( $f );

$obowod=$promien*PI;
echo "obwód wynosi: $obowod";
$pole = 2 * $promien * PI;
echo "pole wynosi: $pole";
```
