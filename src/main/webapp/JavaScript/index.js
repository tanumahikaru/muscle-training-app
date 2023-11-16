/**
 * 
 */
function togglePasswordVisibility() {
    var passwordInput = document.querySelector('.password-input');
    passwordInput.type = (passwordInput.type === 'password') ? 'text' : 'password';
}