package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MuscleRecordDAO;
import dao.UserDAO;
import dto.MuscleRecord;
import dto.UserDTO;
import util.GenerateHashedPw;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getParameter("UTF-8");

		String mail = request.getParameter("mail");
		String pw = request.getParameter("pw");

		// 入力されたIDをもとにソルトを取得する。
		String salt = UserDAO.getSalt(mail);

		// 取得したソルトがnullの場合は対象のユーザがいないので、Errorでログイン画面に戻す
		if (salt == null) {
			String view = "/?error=1"; // URLはhttp://localhost:8080/MuscleTrainingApp/という意味
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			return;
		}

		// 取得したソルトを使って入力したPWをハッシュ化
		String hashedPw = GenerateHashedPw.getSafetyPassword(pw, salt);

		// 入力されたID、ハッシュ化したPWに一致するユーザを検索する
		UserDTO user = UserDAO.login(mail, hashedPw);

		if (user == null) {
			// ログイン失敗時index.htmlを表示
			String view = "/?error=1";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		} else {
			// ログイン成功時の処理
			// 初回ログインかどうかの判定
			System.out.println(user.getLast_login());
			
			
			MuscleRecord latestRecord = MuscleRecordDAO.selectLatestMuscleRecord();

			if (latestRecord != null) {
				request.setAttribute("latestRecord", latestRecord);
			}

			// ログイン情報をセッションに登録
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			// ログイン後のホーム画面へ遷移
			String view = "WEB-INF/view/home.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
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
