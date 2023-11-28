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
 * Servlet implementation class SearchTrainingServlet
 */
@WebServlet("/SearchRecipeServlet")
public class SearchRecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchRecipeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
		
		// 検索キーワードを取得
        String searchKeyword = request.getParameter("searchKeyword");
        System.out.println("Search Keyword: " + searchKeyword);

        // DAOメソッドに検索キーワードを渡して結果を取得
        List<Meal_menuDTO> menu;
        
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            // 検索キーワードがある場合は検索を実行
            menu = Meal_menuDAO.searchRecipeByName(searchKeyword);
        } else {
            // 検索キーワードがない場合はデフォルトのカテゴリーで検索
            int defaultRecipeId = 1;  // デフォルトのポジションID（腕）を指定
            menu = Meal_menuDAO.selectMeal_menu(defaultRecipeId);
        }

        request.setAttribute("list", menu);

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