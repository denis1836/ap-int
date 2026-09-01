function updateTimer() {
    const timer = document.getElementById("timer-p");
    const now = new Date();
    let currentYear = now.getFullYear();
    let targetDate = new Date(currentYear, 0, 21);

    if (now > targetDate) {
        targetDate = new Date(currentYear + 1, 0, 21);
    }

    const diff = targetDate - now;

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    timer.innerHTML = 
        `${days}dni ${hours}godzin ${minutes}minut ${seconds}sekund`;

    if (diff < 0) {
        clearInterval(interval);
        timer.innerHTML = "To dzisiaj!";
    }
}

const interval = setInterval(updateTimer, 1000);

function pokazTimer() {
    const timerbox = document.getElementById("timer-box");
    timerbox.classList.toggle("active");
}

function ukryjTimer() {
    document.getElementById("timer-box").classList.remove("active");
}

updateTimer()