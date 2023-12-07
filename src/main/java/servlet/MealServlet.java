package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MealSuggestionDAO;
import dto.Meal_menuDTO;

@WebServlet("/MealServlet")
public class MealServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MealSuggestionDAO mealSuggestionDAO;

    public void init() {
        mealSuggestionDAO = new MealSuggestionDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ランダムで主菜フラグが true のデータを取得
        Meal_menuDTO mealSuggestion = mealSuggestionDAO.selectRandomMealSuggestionWithMainDishFlag();

        // リクエスト属性に設定
        request.setAttribute("mealSuggestion", mealSuggestion);

        // フォワード先のJSPでmealSuggestionを使いたい場合、リクエスト属性にセット
        request.getRequestDispatcher("WEB-INF/view/meal-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mealName = request.getParameter("mealName");
        String mealDescription = request.getParameter("mealDescription");

        HttpSession session = request.getSession();
        session.setAttribute("mealName", mealName);
        session.setAttribute("mealDescription", mealDescription);

        // GETメソッドを呼び出してランダムで主菜フラグが true のデータを取得
        response.sendRedirect("MealServlet");
    }
}
