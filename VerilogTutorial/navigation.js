// Get all dropdown buttons and their corresponding content
const dropdownButtons = document.querySelectorAll('.dropdown-button');
const dropdownContents = document.querySelectorAll('.dropdown-content');

// Add click event listeners to toggle the dropdowns
dropdownButtons.forEach((button, index) => {
    button.addEventListener('click', () => {
        toggleDropdown(index);
    });
});

// Function to toggle a dropdown by index
function toggleDropdown(index) {
    dropdownContents.forEach((content, i) => {
        if (i === index) {
            // Toggle the visibility of the clicked dropdown content
            content.classList.toggle('show');
        } else {
            // Hide other dropdown contents
            content.classList.remove('show');
        }
    });
}

// Close dropdowns if the user clicks outside of them
window.addEventListener('click', (event) => {
    if (!event.target.matches('.dropdown-button')) {
        dropdownContents.forEach((content) => {
            content.classList.remove('show');
        });
    }
});
