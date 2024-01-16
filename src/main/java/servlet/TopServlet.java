package servlet;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MuscleRecordDAO;
import dto.UserDTO;

@WebServlet("/TopServlet")
public class TopServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TopServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            // ログインしていない場合はログイン画面へリダイレクト
            response.sendRedirect("./");
            return;
        }

        // weight テーブルからデータを取得
        List<Double> weightData = getWeightDataFromDatabase(user.getId());
        request.setAttribute("weightData", weightData);

        // フォワード
        String view = "WEB-INF/view/home.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    private List<Double> getWeightDataFromDatabase(int userId) {
        List<Double> weightData = new ArrayList<>();
        try (Connection connection = MuscleRecordDAO.getConnection()) {
            String query = "SELECT weight FROM weight WHERE user_id = ? ORDER BY date";
            try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        double weight = rs.getDouble("weight");
                        weightData.add(weight);
                    }
                }
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
            // 必要に応じてエラーハンドリングを追加
        }
        return weightData;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
