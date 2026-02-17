document.addEventListener("DOMContentLoaded", function () {
    console.log("app.js loaded successfully");

    var btn = document.getElementById("demo-btn");
    if (btn) {
        btn.addEventListener("click", function () {
            var output = document.getElementById("js-output");
            output.textContent = "JavaScript is working! Timestamp: " + new Date().toLocaleTimeString();
        });
    }
});
