console.log("動いてるよ")
document.addEventListener('DOMContentLoaded', () => {
	const togglePasswordButton = document.getElementById('toggle-password');
	const passwordInput = document.getElementById('password-input');

	togglePasswordButton.addEventListener('click', () => {
		// パスワードの表示/非表示を切り替える
		const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
		passwordInput.setAttribute('type', type);

		// アイコンを切り替える
		togglePasswordButton.textContent = type === 'password' ? '' : '';
	});
});