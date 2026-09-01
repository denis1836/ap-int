<?php
    $wynik = "";
    $pola = ["name", "tel", "adres", "nip", "cart", "deliv-method"];

    foreach ($pola as $pole) {
        if(isset($_POST[$pole])) {
            $wynik .= $pole . ": " . $_POST[$pole] . "\n";
        }
    }

    $folder = "zamowienia";
    if(!is_dir($folder)){
        mkdir($folder);
    }

    $pliki = glob($folder . "/zamowienie-*.txt");
    $il = count($pliki) + 1;

    $n_plik = $folder . "/zamowienie-" . $il . ".txt";

    file_put_contents($n_plik, $wynik);

    echo "Zamówienie zapisane jako: \"$n_plik\"";
?>