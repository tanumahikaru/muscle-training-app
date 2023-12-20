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
import dto.UserDTO;

@WebServlet("/RegistrationServlet2")
public class RegistrationServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
    	 // セッションからユーザーIDを取得
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        int userId = user.getId();

        	String foodName = request.getParameter("foodName");
        	String FoodStr = request.getParameter("calorie");
        	int calorie = Integer.parseInt(FoodStr);
            
            
            System.out.println("ゆーざiD"+userId);
            System.out.println("食べ物の名前"+foodName);
            System.out.println("カロリー"+calorie);
          
            
            // meal_record テーブルにデータを登録
            RegistrationDAO.insertMealRecord2(userId, foodName, calorie);
            //System.out.println("こんにちは");
            System.out.println("食べ物の名前"+foodName);
            System.out.println("カロリー"+calorie);
           
        // JSPに転送
            String view = "WEB-INF/view/meal-list.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);
        
    }
}
