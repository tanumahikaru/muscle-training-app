package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MaterialDAO;
import dao.Meal_menuDAO;
import dto.MaterialDTO;
import dto.Meal_menuDTO;
import dto.RecipeDTO;

/**
 * Servlet implementation class MealMenuDetailServlet
 */
@WebServlet("/MealMenuDetailServlet")
public class MealMenuDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MealMenuDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Meal_menuDTO menu = Meal_menuDAO.SelectMealMenuById(id);
        List<MaterialDTO> materials = MaterialDAO.SelectMaterialsByFoodId(id);
        List<RecipeDTO> recipes = Meal_menuDAO.selectRecipeByFoodIdAndStep(menu.getFood_id());
        
        System.out.println("取れてる？"+menu.getFood_id());
        
        HttpSession session = request.getSession();
        session.setAttribute("detail", menu);
        session.setAttribute("materials", materials);
        session.setAttribute("recipeList", recipes); 

        request.setAttribute("menu", menu);
        request.setAttribute("materials", materials);
        request.setAttribute("recipeList", recipes);
        

        String view = "WEB-INF/view/meal-menu-detail.jsp";
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
