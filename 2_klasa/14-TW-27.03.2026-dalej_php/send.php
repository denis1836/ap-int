<?php
    $wynik = "";
    $pola = ["name", "tel", "adres", "nip", "cart", "deliv_method"];


    //plik
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


    //mysql db
    echo "\n---Zapisywanie do DB---\n";

    $name = $_POST['name'] ?? '';
    $tel = $_POST['tel'] ?? '';
    $adres = $_POST['adres'] ?? '';
    $nip = $_POST['nip'] ?? '';
    $cart = $_POST['cart'] ?? '';
    $deliv_method = $_POST['deliv_method'] ?? '';

    $con = mysqli_connect('localhost', 'root', '', 'sklep_db');

    if (!$con) {
        die("Błąd połączenia: " . mysqli_connect_error());
    }

    $query = "INSERT INTO zamowienia (name, tel, adres, nip, cart, deliv_method)
            VALUES ('$name', '$tel', '$adres', '$nip', '$cart', '$deliv_method')";

    $result = mysqli_query($con, $query);

    if ($result) {
        echo "Zapisano $pole<br>";
    } else {
        echo "Błąd: " . mysqli_error($con) . "<br>";
    }

    mysqli_close($con);
?>