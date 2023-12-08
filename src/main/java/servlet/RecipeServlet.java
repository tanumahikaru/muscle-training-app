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

@WebServlet("/RecipeServlet")
public class RecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // カテゴリIDを取得
        String categoryIdParam = request.getParameter("category_Id");

        int category_Id;

        // カテゴリIDが指定されているかどうかを確認
        if (categoryIdParam != null) {
            // 指定されている場合はその値を使用
            category_Id = Integer.parseInt(categoryIdParam);
        } else {
            // 指定されていない場合はデフォルトのカテゴリIDを使用
            category_Id = 1; // 適切なデフォルト値に変更してください
        }

        // カテゴリIDに基づいてレシピを取得
        List<Meal_menuDTO> meal_menu = Meal_menuDAO.selectMeal_menu(category_Id);

        // カテゴリIDに基づいてカテゴリ名を取得
        String categoryName = Meal_menuDAO.getCategoryNameById(category_Id);

        // カテゴリ名がnullの場合、"検索した"を設定
        if (categoryName == null) {
            categoryName = "検索した";
        }

        // リクエスト属性に設定
        request.setAttribute("list", meal_menu);
        request.setAttribute("categoryName", categoryName);

        // JSPに転送
        String view = "WEB-INF/view/meal_menu.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
