# PHP pliki i katalogi

## Podział kodu

include lub require

```PHP
    include('nazwa_pliku');
    lub
    include 'nazwa_pliku';
```

### Różnica pomiędzy include i require

* include - wygeneruje ostrzeżenie ale skrypt będzie dalej działał
* require - spowoduje zgłoszenie błędu i zakończenie skryptu

## Operacje na plikach

* Czy plik istnieje?

    ```PHP
        file_exists('nazwa pliku');
    ```

  ### Przykład

    ```PHP
        if(file_exists('wykonaj.php')){
            echo "Plik odnaleziony";
        }
    ```

* Rozmiar pliku:

    ```PHP
        file_size('nazwa pliku');
    ```

* Tworzenie pliku (jeżeli istnieje to modyfikacja daty)

    ```PHP
        touch('nazwa pliku');
    ```

* Usuwanie pliku

    ```PHP
        unlink('nazwa pliku');
    ```

* Otwieranie, zapisywanie i zamykanie pliku:

    ```PHP
        fopen('nazwa_pliku', 'tryb_otwarcia');
    ```

    Tryby otwarcia:

    * r - plik otwarty w trybie tylko do odczytu (reading)
    * w - plik otwarty w trybie tylko do zapisu (writing)
    * a - plik otwarty w trybie tylko do dopisywanie (appending)
  
  ### Przykład
  
    ```PHP
        $a = fopen('test.txt', 'r');

        fclose($a);
    ```

  ### Przykład

    ```PHP
        fwrite(zmienna/deskryptor, ciąg znaków);
    ```

    ```PHP
        $tekst="Ania ma kota a kot ma Anię";
        $p = fopen('dane.txt', w);
        fwrite($p, $tekst_wstawiany)
    ```

    ### Zadanie

    ```PHP
        if ( ! file_exists('tekstowy.txt')) {
            touch('tekstowy.txt');
        }
        
        $plik = fopen('tekstowy.txt','a');
        
        for($i = 0; $i < 3; $i++) {
            fwrite($plik, "Elektroniczne Zakłady Naukowe\n");
        }
        
        fclose($plik);
    ```

    * Odczyt danych
        * fgets - odczytuje jedną linię z pliku (lub określoną liczbę znaków)
            ```PHP 
                fgets(deskryptor, ile_znaków); 
            ```
        * feof() - testowanie osiągnięcia końca pliku 
            ```PHP
                feof(deskryptor);   
            ```
        * fgetc() - odczytywanie pojedynczych znaków
            ```PHP
                fgetc(deskryptor);
            ```
        * readfile('nazwa_pliku') - odczytuje cały plik i od razu wyświetla jego zawartość, oraz dopisuje ilośc bajtów na końcu tekstu
            ```PHP
                readfile('plik.txt');
            ```

        * file_get_contents('nazwa pliku') - odczytuje cały plik i zapisuje jego zawartość do zmiennej jako tekst
            ```PHP
                file_get_contents('test.txt');
            ```
    
    ### Zadanie
    ```PHP
        readfile('testowy.txt');

        //albo

        $tekst = file_get_contets('tekstowy.txt');
        echo "$tekst";
    ```

## Operacje na katalogach
n - nazwa katalogu
* tworzenie katalogu
    
    ```PHP 
        mkdir('n');
    ``` 

* usuwanie katalogu

    ```PHP
        rmdir('n');
    ```

* otwieranie katalogu

    ```PHP
        opendir('n');
    ```
* odczyt katalogu

    ```PHP
        readdir('n');
    ```
* zamykanie katalogu

    ```PHP
        closedir('n');
    ```

## Funkcje wyjścia
* exit(arg)
* dir(arg)

## Zadanie
W folderze "zdanie_faktura"