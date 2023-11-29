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

@WebServlet("/SearchRecipeServlet")
public class SearchRecipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SearchRecipeServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 検索キーワードを取得
        String searchKeyword = request.getParameter("searchKeyword");

        // DAOメソッドに検索キーワードを渡して結果を取得
        List<Meal_menuDTO> menu;

        // デフォルトのポジションID（腕）を指定
        int defaultCategoryId = 1;

        // カテゴリ名を取得
        String categoryName = Meal_menuDAO.getCategoryNameById(defaultCategoryId);

     // カテゴリ名がnullの場合、検索時のメッセージを設定
     if (categoryName == null || searchKeyword != null && !searchKeyword.isEmpty()) {
         categoryName = "検索した";
     }


        // カテゴリ名をリクエストに設定
        request.setAttribute("categoryName", categoryName);

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            // 検索キーワードがある場合は検索を実行
            menu = Meal_menuDAO.searchRecipeByName(searchKeyword);

            // 検索結果がnullの場合、カテゴリ名を "検索した" に変更
            if (menu == null || menu.isEmpty()) {
                categoryName = "検索した";
                request.setAttribute("categoryName", categoryName);
            }
        } else {
            // 検索キーワードがない場合はデフォルトのカテゴリーで検索
            int defaultRecipeId = 1; // デフォルトのポジションID（肉）を指定
            menu = Meal_menuDAO.selectMeal_menu(defaultRecipeId);
        }

        request.setAttribute("list", menu);

        String view = "WEB-INF/view/meal_menu.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
