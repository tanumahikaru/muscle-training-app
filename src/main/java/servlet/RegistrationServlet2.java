import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.RegistrationDAO;
import dto.UserDTO;

@WebServlet("/RegistrationServlet2")
public class RegistrationServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションからユーザーIDを取得
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // ユーザーがログインしていない場合はログインページにリダイレクト
        if (user == null) {
            response.sendRedirect("login.jsp"); // ログインページのパスに変更してください
            return;
        }

        int userId = user.getId();

        // フォームからデータを取得
        String food_name = request.getParameter("food_name");
        String calorieStr = request.getParameter("calorie");
        int calorie = Integer.parseInt(calorieStr);
        int foodId = 0;

        // 必要に応じてデータのバリデーションや変換を行う

        // meal_record テーブルにデータを登録
        RegistrationDAO.insertMealRecord(userId, food_name, calorie, foodId);

        // JSPに転送
        String view = "WEB-INF/view/meal-list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
}
