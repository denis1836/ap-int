<?php
    $client = mysqli_connect("localhost","root","","ankieta_db") or die("Connectcion error");
    if (mysqli_connect_errno()) {
        echo((string)mysqli_connect_error());
        exit();
    }
    
    $query = 'DELETE FROM odpowiedzi WHERE ID_odpowiedzi = ' . $_GET['id'] . ';';
    $result = mysqli_query($client, $query) or die('Query Error');
    if($result){
        echo "Usunięto pomyślnie!";
        echo "<br><a href='./formularz.html'>Powrót do formularza</a>";
    }

    mysqli_close($client);
?>