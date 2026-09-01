<?php
    $DB_HREF = "localhost";
    $DB_USER = "root";
    $DB_PASS = "";
    $DB_NAME = "ankieta_db";

    $POOL = mysqli_connect($DB_HREF, $DB_USER, $DB_PASS, $DB_NAME);
    if (!$POOL) {
        die("Błąd połączenia: " . mysqli_connect_error());
    }

    $id = isset($_POST['id']) ? intval($_POST['id']) : 0;

    $name = $_POST['in-name'] ?? '';
    $sur_name = $_POST['in-sur_name'] ?? '';
    $sex = $_POST['in-sex'] ?? '';
    $age = $_POST['in-age'] ?? '';
    $music_radio = $_POST['in-music'] ?? '';
    $music_text = $_POST['in-music-misc'] ?? '';
    $browser = $_POST['in-browser-sel'] ?? '';
    $comm = $_POST['in-comment'] ?? '';

    if ($music_radio === 'other' && !empty($music_text)) {
        $music = $music_text;
    } else {
        $music = $music_radio;
    }

    $QUERY = "
        UPDATE odpowiedzi SET 
            imie = '$name', 
            nazwisko = '$sur_name', 
            plec = '$sex', 
            wiek = '$age', 
            muzyka = '$music', 
            browser = '$browser', 
            komentarz = '$comm'
        WHERE ID_odpowiedzi = $id;
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