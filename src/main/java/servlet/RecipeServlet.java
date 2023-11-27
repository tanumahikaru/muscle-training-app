package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Meal_menuDAO;
import dto.Meal_menuDTO;
/**
 * Servlet implementation class FreeTrainingServlet
 */
@WebServlet("/RecipeServlet")
public class RecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecipeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // ボタンがクリックされたときに渡された positionId を取得
        String categoryIdParam = request.getParameter("category_Id");

        int category_Id;

        if (categoryIdParam != null) {
            // ボタンがクリックされた場合はその値を使う
        	category_Id = Integer.parseInt(categoryIdParam);
        } else {
            // ボタンがクリックされていない場合はデフォルトの positionId を指定する
        	category_Id = 1;  // ここでは腕の positionId をデフォルトとしていますが、適切な値に変更してください
        }
		
		List<Meal_menuDTO> meal_menu = Meal_menuDAO.selectMeal_menu(category_Id);
		
		request.setAttribute("list", meal_menu);
		
		String view = "WEB-INF/view/meal_menu.jsp";
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
