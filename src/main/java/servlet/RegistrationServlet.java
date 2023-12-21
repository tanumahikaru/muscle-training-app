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
        session.setAttribute("meal_menu", menu);
        
        //ここから考えて
       
      
        // 選択されたオプションを取得
        String option = request.getParameter("kome");
        
        // データベースへの登録
        if (option != null) {
        	String foodName = "ご飯";
            int calorie = 0;
            switch (option) {
                case "1":
                    // 大(200g)が選択された場合の処理
                	calorie = 200;
                    RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                    break;
                case "2":
                    // 中(150g)が選択された場合の処理
                	calorie = 100;
                    RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                    break;
                case "3":
                    // 小(100g)が選択された場合の処理
                	calorie = 50;
                    RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                    break;
                default:
                    // 何も選択されていない場合の処理
                    break;
            }
        }
            // パンの選択されたオプションを取得
            String breadOption = request.getParameter("pan");
            
            // データベースへの登録
            if (breadOption != null) {
                String foodName = "食パン"; // 適切な食品名を設定する
                int calorie = 0;
                switch (breadOption) {
                    case "4":
                        // プレーンが選択された場合の処理
                        calorie = 100; // 適切なカロリーを設定する
                        RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                        break;
                    case "5":
                        // ジャムが選択された場合の処理
                        calorie = 150; // 適切なカロリーを設定する
                        RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                        break;
                    case "6":
                        // マーガリンが選択された場合の処理
                        calorie = 120; // 適切なカロリーを設定する
                        RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                        break;
                    case "7":
                        // バターが選択された場合の処理
                        calorie = 180; // 適切なカロリーを設定する
                        RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
                        break;
                    default:
                        // 何も選択されていない場合の処理
                        break;
            }

        // セッションに今日のおすすめメニューをセット
        // ここでMeal_menuDTOをセッションにセットする
        // 例：session.setAttribute("meal_menu", meal_menu);

        // JSPに転送
        String view = "/MealServlet";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
   }
}