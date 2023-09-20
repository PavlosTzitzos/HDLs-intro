// Function to set the theme
function setTheme(theme) {
    const select = document.getElementById('theme-select');
    const stylesheet = document.getElementById('theme-stylesheet');

    // Update the class of the HTML body element to apply the selected theme
    document.body.className = theme + '-theme';

    // Update the theme selection dropdown to reflect the current theme
    select.value = theme;

    // Save the selected theme to local storage
    localStorage.setItem('selectedTheme', theme);

    // Update the stylesheet link to match the selected theme
    //stylesheet.href = 'theme-' + theme + '.css';
}

// Function to load the saved theme from local storage
function loadTheme() {
    const selectedTheme = localStorage.getItem('selectedTheme');
    if (selectedTheme) {
        setTheme(selectedTheme);
    }
}

// Initialize the theme
loadTheme();

// Add an event listener for theme selection changes
document.getElementById('theme-select').addEventListener('change', function() {
    setTheme(this.value);
});
