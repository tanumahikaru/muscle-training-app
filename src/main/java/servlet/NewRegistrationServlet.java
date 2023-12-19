package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RegistrationDAO;
import dto.Meal_menuDTO;
import dto.UserDTO;

/**
 * Servlet implementation class TopServlet
 */
@WebServlet("/NewRegistrationServlet")
public class NewRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewRegistrationServlet() {
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
		
		  int userId = users.getId();

	        // セッションから値を取得
	        Meal_menuDTO menu = (Meal_menuDTO) session.getAttribute("detail");

	        // menuがnullでないことを確認
	        if (menu != null) {
	            String foodName = menu.getFood_name();
	            int calorie = menu.getCalorie();
	            int foodId = menu.getFood_id();

	            // meal_record テーブルにデータを登録
	            RegistrationDAO.insertMealRecord(userId, foodName, calorie, foodId);
	        }
	        session.setAttribute("meal_menu", menu);

		
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
