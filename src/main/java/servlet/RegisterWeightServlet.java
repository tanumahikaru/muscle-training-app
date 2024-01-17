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

import dao.MuscleRecordDAO;
import dao.UserDAO;
import dto.UserDTO;
import dto.WeightDTO;

@WebServlet("/RegisterWeightServlet")
public class RegisterWeightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterWeightServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        int userId = -1;
        UserDTO user1 = (UserDTO) session.getAttribute("user");

        if (user1 != null) {
            String mail = user1.getMail();
            if (mail != null && !mail.isEmpty()) {
                userId = UserDAO.getUserIdByMail(mail);
                
            }
        }

        System.out.println(userId);        
        
        String weightStr = request.getParameter("weight");

        if (weightStr != null && !weightStr.isEmpty()) {
            float weight = Float.parseFloat(weightStr);
            System.out.println(weight);
            // 今日の日付を取得
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            System.out.println(today);
            
            WeightDTO we = new WeightDTO(-1, userId, today, weight);
            // 体重を更新するメソッドを呼び出し
            
            if(UserDAO.getTodaysWeight(we) == 0) {
            	UserDAO.registerWeight(we);
            } else {
            	UserDAO.UpdateWeight(we);
            }
        }

//		作成中
        List<Double> weightData = MuscleRecordDAO.getWeightsByUserId(user1.getId()); // WeightDAOはデータベースからデータを取得するメソッドを実装していると仮定
        // リクエスト属性に weight データをセット
        request.setAttribute("weightData", weightData);
        
        String view = "WEB-INF/view/home.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
