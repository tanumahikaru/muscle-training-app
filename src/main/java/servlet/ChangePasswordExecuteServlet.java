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
 * Servlet implementation class ChangePasswordExecuteServlet
 */
@WebServlet("/ChangePasswordExecuteServlet")
public class ChangePasswordExecuteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordExecuteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		
	     // パスワードの長さが8~16文字でない場合にエラー処理
        if (password1.length() < 8 || password1.length() > 16) {
            // エラーメッセージをリクエスト属性にセット
            request.setAttribute("error", "パスワードは8~16文字で入力してください。");

            // エラーページにフォワード
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("WEB-INF/view/change-password.jsp?error=1");
            errorDispatcher.forward(request, response);
            return;
        } else if(!password1.equals(password2)) {
        	// エラーメッセージをリクエスト属性にセット
            request.setAttribute("error", "パスワードを正しく入力してください");

            // エラーページにフォワード
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("WEB-INF/view/change-password.jsp?error=1");
            errorDispatcher.forward(request, response);
        }
        
        HttpSession session = request.getSession();
        int userId = Integer.parseInt((String)session.getAttribute("userId"));
        
        if(UserDAO.updatePassword(password1, userId) == 0) {
        	// 更新出来ない場合の処理を書く
        	// エラーメッセージをリクエスト属性にセット
            request.setAttribute("error", "パスワードの変更に失敗しました");
            // エラーページにフォワード
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("WEB-INF/view/change-password.jsp?error=1");
            errorDispatcher.forward(request, response);
        } else {


            // ワンタイムパスワードを削除する処理を記述
            UserDAO.deleteOnetimePassword(userId);


    		String view = "/";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
    		dispatcher.forward(request, response);
        }
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
