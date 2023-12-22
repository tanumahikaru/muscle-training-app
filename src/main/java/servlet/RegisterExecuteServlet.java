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
import dto.UserDTO;
import dto.WeightDTO;

/**
 * Servlet implementation class ExecuteServlet
 */
@WebServlet("/RegisterExecuteServlet")
public class RegisterExecuteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterExecuteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// 入力データの取得
		UserDTO user = (UserDTO)session.getAttribute("input_data");
		WeightDTO we = (WeightDTO)session.getAttribute("weight_data");
		// ユーザーの登録処理を行い、ユーザーIDを取得
		int userId = UserDAO.registerUserAndGetUserId(user);
	    System.out.println(userId);

	    if (userId != -1) {
	    	
	    	we.setUser_id(userId);
	    	
	        // 体重の登録処理
	        int result2 = UserDAO.registerWeight(we);

	        String path = "";

	        if (result2 == 1) {
	            // 登録に成功したので、sessionのデータを削除
	            session.removeAttribute("input_data");

	            path = "WEB-INF/view/home.jsp";
	        } else {
	            // 失敗した場合はパラメータ付きで登録画面に戻す
	            path = "WEB-INF/view/register-user.jsp?error=1";
	        }
	        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
	        dispatcher.forward(request, response);
	    } else {
	        // 登録に失敗した場合の処理
	        request.setAttribute("error", "ユーザーの登録に失敗しました。");
	        RequestDispatcher errorDispatcher = request.getRequestDispatcher("WEB-INF/view/register-user.jsp?error=2");
	        errorDispatcher.forward(request, response);
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
