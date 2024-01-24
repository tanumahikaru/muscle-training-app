public class Validate {
	// パスワードが有効かどうかを判定するメソッド
	public boolean passwordIsValid(String password, int minLength, int maxLength) {
		if(password.equals("") {
			// パスワードが空の場合falseを返す
			return false;
		} else if(password.length() < minLength && maxLength < password.length()) {
			// パスワードの長さが指定範囲外だった場合falseを返す
			return false;
		}
	}

}