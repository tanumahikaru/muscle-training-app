package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.UserDTO;

/**
 * Servlet implementation class TopServlet
 */
@WebServlet("/TopServlet2")
public class TopServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//処理の始めにログイン状態のチェックを行う。
		HttpSession session = request.getSession();
		UserDTO users = (UserDTO)session.getAttribute("user");
		System.out.println("Session User: " + users);
		if(users == null){
			//セッションの中身がnullであれば不正アクセスと判断し
			//ログイン画面へ戻る
			String view = "./";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			return;
		}
		
		// 正常な画面を表示
		String view = "WEB-INF/view/home.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
