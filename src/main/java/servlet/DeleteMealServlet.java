package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DeleteMealDAO;

@WebServlet("/DeleteMealServlet")
public class DeleteMealServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 食べ物IDを取得
        String idStr = request.getParameter("id");
        int mealId = Integer.parseInt(idStr);

        // DAOのメソッド呼び出し
        int result = DeleteMealDAO.deleteMealById(mealId);

        if (result > 0) {
            System.out.println("削除が成功しました。");
        } else {
            System.out.println("削除が失敗しました。");
        }

        // JSPに転送
        String view = "/MealServlet";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
}