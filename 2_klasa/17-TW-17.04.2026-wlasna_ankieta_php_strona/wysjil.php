<?php
    $DB_HREF = "localhost";
    $DB_USER = "root";
    $DB_PASS = "";
    $DB_NAME = "ankieta_db";

    $POOL = mysqli_connect($DB_HREF, $DB_USER, $DB_PASS, $DB_NAME);
    if (!$POOL) {
        die("Błąd połączenia: " . mysqli_connect_error());
    }

    $name = $_GET['in-name'] ?? '';
    $sur_name = $_GET['in-sur_name'] ?? '';
    $sex = $_GET['in-sex'] ?? '';
    $age = $_GET['in-age'] ?? '';
    $music_radio = $_GET['in-music'] ?? '';
    $music_text = $_GET['in-music-misc'] ?? '';
    $browser = $_GET['in-browser-sel'] ?? '';
    $comm = $_GET['in-comment'] ?? '';

    if ($music_radio === 'other' && !empty($music_text)) {
        $music = $music_text;
    } else {
        $music = $music_radio;
    }

    $QUERY = "
        INSERT INTO odpowiedzi(imie, nazwisko, plec, wiek, muzyka, browser, komentarz) 
        VALUES('$name', '$sur_name', '$sex', '$age', '$music', '$browser', '$comm');
    ";

    $res = mysqli_query($POOL, $QUERY);

    if($res){
        echo "Zapisano pomyślnie!";
        echo "<br><a href='./formularz.html'>Powrót do formularza</a>";
    }
    else{
        echo "Wystąpił błąd: ". mysqli_error($POOL)." \n";
    }

    mysqli_close($POOL);
?>