<html>
    <head>
        <meta charset="utf-8">
    </head>

    <body>
        <h1>Zawartość bazy danych: </h1>

        <?php
        $db = mysqli_connect("localhost", "root", "", "sklep_db");

        if (mysqli_connect_errno()) {
            echo "Błąd połączenia z bazą danych";
        }

        $db_req = mysqli_query($db, "SELECT * FROM zamowienia");

        echo "
            <table border='1'>
            <tr>
            <th>ID</th> 
            <th>Imie i Nazwisko</th>
            <th>Telefon</th>
            <th>Adres</th>
            <th>ID koszyka</th>
            <th>NIP</th>
            <th>Sposób dostawy</th>
            <th>Funkcje</th>
            </tr>
        ";

        while ($row = mysqli_fetch_array($db_req)) {
            echo "
                <tr>
                <td>{$row['id']}</td>
                <td>{$row['name']}</td>
                <td>{$row['tel']}</td>
                <td>{$row['adres']}</td>
                <td>{$row['cart']}</td>
                <td>{$row['nip']}</td>
                <td>{$row['deliv_method']}</td>
                <td>
                    <a href='usun.php?a=del&id={$row['id']}'>Usun wpis</a>
                    <a href='edytuj.php?a=edit&id={$row['id']}'>Edytuj wpis</a>
                </td>
                </tr>
            ";
        }

        echo "</table>";
        ?>

        <input type="button" value="Powróc do formularza" onclick=location.href='./formularz.html'>
    </body>
</html> 