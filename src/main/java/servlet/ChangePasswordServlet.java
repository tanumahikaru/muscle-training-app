package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePasswordServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		String code = request.getParameter("code");
		String userId = UserDAO.getUserIdByOnetimePass(code);
		if (userId.equals("")) {
			// 認証コードが間違っていた場合の処理
            // エラーページにフォワード
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("WEB-INF/view/code-input.jsp?error=1");
            try {
				errorDispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			} catch (IOException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
			return;
		} else {
			// 認証コードが合っていた場合は、パスワードを変更するユーザーのIDをセッションに保存し、パスワード入力画面に進む
			HttpSession session = request.getSession();
			session.setAttribute("userId", userId);
			System.out.println("セッションのuser_ID" + userId);

			String view = "WEB-INF/view/change-password.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			} catch (IOException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
