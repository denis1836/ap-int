<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="./styl.css">
    </head>

    <body>
        <h1>Zawartość bazy danych: </h1>

        <?php
            $DB_HREF = "localhost";
            $DB_USER = "root";
            $DB_PASS = "";
            $DB_NAME = "ankieta_db";

            $POOL = mysqli_connect($DB_HREF, $DB_USER, $DB_PASS, $DB_NAME);
            if (!$POOL) {
                die("Błąd połączenia: " . mysqli_connect_error());
            }

            $query = "SELECT * FROM odpowiedzi;";

            $res = mysqli_query($POOL, $query);

            echo "
                <table border='1'>
                    <tr>
                        <th>ID Odpowiedzi</th> 
                        <th>Imie</th>
                        <th>Naziwsko</th>
                        <th>Plec</th>
                        <th>Wiek</th>
                        <th>Muzyka</th>
                        <th>Przeglądarka</th>
                        <th>Komentarz</th>
                    </tr>
            ";

            while ($row = mysqli_fetch_array($res)){
                echo "
                    <tr>
                        <td>{$row['ID_odpowiedzi']}</td>
                        <td>{$row['imie']}</td>
                        <td>{$row['nazwisko']}</td>
                        <td>{$row['plec']}</td>
                        <td>{$row['wiek']}</td>
                        <td>{$row['muzyka']}</td>
                        <td>{$row['browser']}</td>  
                        <td>{$row['komentarz']}</td>
                        <td>
                            <a href='./usun.php?id={$row['ID_odpowiedzi']}'>Usuń</a>
                            |
                            <a href='./edytuj.php?id={$row['ID_odpowiedzi']}'>Edytuj</a>
                        </td>
                    </tr>
                ";
            }

            echo "</table>";
        ?>
    </body>
<br>
<input type="button" value="Powróc do formularza" onclick=location.href='./formularz.html'>
</html>