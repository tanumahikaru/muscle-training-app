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

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションからユーザーIDを取得
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        int userId = user.getId();

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

        // JSPに転送
        String view = "WEB-INF/view/meal-list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
}
