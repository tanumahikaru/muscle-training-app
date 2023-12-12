package servlet;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import util.MailUtil;

/**
 * Servlet implementation class CodeInputServlet
 */
@WebServlet("/CodeInputServlet")
public class CodeInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CodeInputServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mail = request.getParameter("mail");

		// 入力されたIDをもとにソルトを取得する。
		String salt = UserDAO.getSalt(mail);

		// 取得したソルトがnullの場合は対象のユーザがいないので、Errorでログイン画面に戻す
		if (salt == null) {
			String view = "/LinkSendFormServlet?error=1"; // URLはhttp://localhost:8080/MuscleTrainingApp/という意味
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			return;
		}

		Random rand = new Random();
		int num = rand.nextInt(900000) + 100000;
		Integer i = Integer.valueOf(num);
		String code = i.toString();

		int userId = UserDAO.getUserIdByMail(mail);

		UserDAO.registerOnetimePass(code, userId);
		
		MailUtil.sendMail(mail, code);
		
		// 入力した認証コードが間違っていた場合、返ってくるエラーを取得
		if(request.getParameter("error") != null) {
			request.setAttribute("error", 1);
		}

		String view = "WEB-INF/view/code-input.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
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
