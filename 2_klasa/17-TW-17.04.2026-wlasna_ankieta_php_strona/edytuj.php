<?php
$client = mysqli_connect("localhost","root","","ankieta_db") or die("Connection error");
if (mysqli_connect_errno()) {
    echo((string)mysqli_connect_error());
    exit();
}

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
$query = "SELECT * FROM odpowiedzi WHERE ID_odpowiedzi = $id;";
$res = mysqli_query($client, $query);
$row = mysqli_fetch_array($res);

if (!$row) {
    die("Nie znaleziono rekordu o podanym ID.");
}

echo('
    <!DOCTYPE html>
    <html lang="pl">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Formularz</title>
        <link rel="stylesheet" href="./styl.css">
    </head>
    <body>
        <form action="./aktualizuj.php" method="POST">
            <input type="hidden" name="id" value="'.$_GET['id'].'">

            <label for="in-name">Podaj swoje imię: </label>
            <input type="text" placeholder="Jan" name="in-name" value="'.$row['imie'].'">
            <br>
            <label for="in-sur_name">Podaj swoje nazwisko: </label>
            <input type="text" placeholder="Kowalski" name="in-sur_name" value="'.$row['nazwisko'].'">
            <br><br>
            <label for="in-sex-radio">Podaj swoją płeć: </label>
            <div id="in-sex-radio">
                <input type="radio" name="in-sex" id="in-sex-m" value="m" '.($row['plec']=='m'?'checked':'').'>
                <label for="in-sex-m">Mężczyzna</label>

                <input type="radio" name="in-sex" id="in-sex-f" value="f" '.($row['plec']=='f'?'checked':'').'>
                <label for="in-sex-f">Kobieta</label>
            </div>
            <br>
            <label for="in-age-radio">Podaj swój wiek: </label>
            <div id="in-age-radio">
                <input type="radio" name="in-age" id="in-age-lt15" value="<15" '.($row['wiek']=='<15'?'checked':'').'>
                <label for="in-age-lt15">Mniej niż 15</label>
                <br>
                <input type="radio" name="in-age" id="in-age-15_19" value="15-19" '.($row['wiek']=='15-19'?'checked':'').'>
                <label for="in-age-15_19">15-19</label>
                <br>
                <input type="radio" name="in-age" id="in-age-20_29" value="20-29" '.($row['wiek']=='20-29'?'checked':'').'>
                <label for="in-age-20_29">20-29</label>
                <br>
                <input type="radio" name="in-age" id="in-age-30_39" value="30-39" '.($row['wiek']=='30-39'?'checked':'').'>
                <label for="in-age-30_39">30-39</label>
                <br>
                <input type="radio" name="in-age" id="in-age-40_60" value="40-60" '.($row['wiek']=='40-60'?'checked':'').'>
                <label for="in-age-40_60">40-60</label>
                <br>
                <input type="radio" name="in-age" id="in-age-gt60" value="60<" '.($row['wiek']=='60<'?'checked':'').'>
                <label for="in-age-gt60">Więcej niż 60</label>
            </div>
            <br>
            <label for="in-music-radio">Jaką lubisz muzykę?</label>
            <div id="in-music-radio">
                <input type="radio" name="in-music" id="in-music-rock" value="rock" '.($row['muzyka']=='rock'?'checked':'').'>
                <label for="in-music-rock">Rock</label>
                <br>
                <input type="radio" name="in-music" id="in-music-hv_mt" value="heavy_metal" '.($row['muzyka']=='heavy_metal'?'checked':'').'>
                <label for="in-music-hv_mt">Heavy Metal</label>
                <br>
                <input type="radio" name="in-music" id="in-music-pop" value="pop" '.($row['muzyka']=='pop'?'checked':'').'>
                <label for="in-music-pop">Pop</label>
                <br>
                <input type="radio" name="in-music" id="in-music-techno" value="techno" '.($row['muzyka']=='techno'?'checked':'').'>
                <label for="in-music-techno">Techno</label>
                <br>
                <input type="radio" name="in-music" id="in-music-classic" value="classic" '.($row['muzyka']=='classic'?'checked':'').'>
                <label for="in-music-classic">Muzyka Klasyczna</label>
                <br>
                <input type="radio" name="in-music" id="in-music-misc" value="other" '.($row['muzyka']!='rock' && $row['muzyka']!='heavy_metal' && $row['muzyka']!='pop' && $row['muzyka']!='techno' && $row['muzyka']!='classic' && $row['muzyka']!='' ? 'checked' : '').'>
                <label for="in-music-misc">Inna: </label>
                <input type="text" name="in-music-misc" value="'.$row['muzyka'].'">
            </div>
            <br>
            <select name="in-browser-sel">
                <option value="chrome" '.($row['browser']=='chrome'?'selected':'').'>Chrome</option>
                <option value="firefox" '.($row['browser']=='firefox'?'selected':'').'>Firefox</option>
                <option value="opera" '.($row['browser']=='opera'?'selected':'').'>Opera</option>
                <option value="brave" '.($row['browser']=='brave'?'selected':'').'>Brave</option>
                <option value="misc" '.($row['browser']=='misc'?'selected':'').'>Inna</option>
            </select>
            <br>
            <label for="in-comment">Podaj Komentarz:</label>
            <input type="text" placeholder="Komentarz" name="in-comment" id="in-comment" value="'.$row['komentarz'].'">
            <br>
            <input type="submit" id="in-submit" value="Zapisz">
        </form>
        
        <input type="button" onclick="location.href=\'./formularz.html\'" value="Wróć">
    </body>
    </html>'
);
    
mysqli_close($client);
?>