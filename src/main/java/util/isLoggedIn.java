import java.util.Objects;
import dto.UserDTO;

		// ログイン済みかどうかの判定
		if(Objects.isNull(user)) {
			String view = "/";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}