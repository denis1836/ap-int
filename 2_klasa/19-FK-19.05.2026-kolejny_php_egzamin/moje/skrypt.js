document.addEventListener('DOMContentLoaded', () => {
    const haircutButton = document.getElementById('haircut_type-btn');
    const haircutCost = document.getElementById('haircut-cost');

    haircutButton.addEventListener('click', () => {
        const haircutType = document.querySelector('input[name="haircut_type"]:checked');

        if (haircutType) {
            haircutCost.innerText = "Cena strzyżenia: " + haircutType.value + " zł";
        } 
    });

});