package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

        UserDTO user = (UserDTO) session.getAttribute("user");

        int userId = UserDAO.getUserIdByMail(user.getMail());
        
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
            UserDAO.registerWeight(we);
        }

        String view = "WEB-INF/view/home.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
