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
        // カテゴリが選択されているか確認
        Integer selectedCategoryId = null;
        if (request.getParameter("category") != null) {
            // カテゴリが選択されている場合は、選択されたカテゴリに基づいてメニューを絞り込む
            selectedCategoryId = Integer.parseInt(request.getParameter("category"));
            List<Meal_menuDTO> filteredMenu = filterMenuByCategory(selectedCategoryId);
            request.setAttribute("list", filteredMenu);
        } else {
        	List<Meal_menuDTO> meal_menu = Meal_menuDAO.selectAllRecipe();
        	request.setAttribute("list", meal_menu);
        }

        // selectedCategoryIdをリクエスト属性に設定
        request.setAttribute("selectedCategoryId", selectedCategoryId);

        String view = "WEB-INF/view/meal_menu.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    // カテゴリに基づいてメニューを絞り込むメソッド
    private List<Meal_menuDTO> filterMenuByCategory(int categoryId) {
        // Meal_menuDAO クラスに、カテゴリに基づいて絞り込むメソッドを追加する必要があります。
        // このメソッドは、Meal_menuDAO クラス内に実装されるべきです。
        return Meal_menuDAO.selectMenuByCategory(categoryId);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
