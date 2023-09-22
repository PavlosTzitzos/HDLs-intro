// Function to copy code to clipboard using Clipboard API
function copyCodeToClipboard(codeId) {
    const codeElement = document.getElementById(codeId);
    const codeText = codeElement.textContent;

    // Create a new text area element
    const textarea = document.createElement('textarea');
    textarea.value = codeText;
    document.body.appendChild(textarea);

    // Select and copy the text to the clipboard
    textarea.select();
    document.execCommand('copy');

    // Clean up: remove the temporary text area
    document.body.removeChild(textarea);

    // Show a confirmation message (you can customize this)
    alert('Code copied to clipboard!');
}

// Add click event listeners to copy buttons
const copyButtons = document.querySelectorAll('.copy-button');
copyButtons.forEach((button) => {
    button.addEventListener('click', () => {
        const codeId = button.getAttribute('data-code-id');
        copyCodeToClipboard(codeId);
    });
});
