console.log("動いてるよ")
document.addEventListener('DOMContentLoaded', () => {
	const togglePassword1Button = document.getElementById('toggle-password1');
	const password1Input = document.getElementById('password1-input');

	togglePassword1Button.addEventListener('click', () => {
		// パスワードの表示/非表示を切り替える
		const type = password1Input.getAttribute('type') === 'password' ? 'text' : 'password';
		password1Input.setAttribute('type', type);

		// アイコンを切り替える
		togglePassword1Button.textContent = type === 'password' ? '' : '';
	});
	
	const togglePassword2Button = document.getElementById('toggle-password2');
	const password2Input = document.getElementById('password2-input');

	togglePassword2Button.addEventListener('click', () => {
		// パスワードの表示/非表示を切り替える
		const type = password2Input.getAttribute('type') === 'password' ? 'text' : 'password';
		password2Input.setAttribute('type', type);

		// アイコンを切り替える
		togglePassword2Button.textContent = type === 'password' ? '' : '';
	});
});
