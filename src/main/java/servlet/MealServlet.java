package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdditionalMealDAO;
import dao.Meal_menuDAO;
import dto.Meal_RecordDTO;
import dto.Meal_menuDTO;
import dto.UserDTO;

@WebServlet("/MealServlet")
public class MealServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // セッションなどからユーザーIDを取得（適切に実装してください）
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        int userId = user.getId();
        request.setAttribute("user_id", userId);

        // AdditionalMealDAO クラスを利用して同じ日に追加された食事のデータを取得
        AdditionalMealDAO additionalMealDAO = new AdditionalMealDAO();
        List<Meal_RecordDTO> mealsAddedOnSameDay = additionalMealDAO.getMealsAddedOnSameDay(userId);
     
        request.setAttribute("mealID", user.getFood_id());
        
        Meal_menuDTO meal_menu = Meal_menuDAO.SelectMealMenuById(user.getFood_id());
        request.setAttribute("meal", meal_menu);
        
     // 本日の摂取カロリーを取得し、セッションに設定
        int totalCalorieIntake = additionalMealDAO.getTotaltotalCalorieIntakeOnSameDay(userId);
        System.out.println("総摂取カロリーを: " + totalCalorieIntake);
        session.setAttribute("totalCalorieIntake", totalCalorieIntake);
        
        // 取得したデータをリクエスト属性にセット
        request.setAttribute("mealsAddedOnSameDay", mealsAddedOnSameDay);
        
        System.out.println("<Meals added on the same day:> " + mealsAddedOnSameDay);
        
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
