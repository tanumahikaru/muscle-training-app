package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLogServlet")
public class UserLogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            // ここで必要なデータを取得し、JSON形式でクライアントに返す（模擬的な例）
            String jsonData = "{ \"data\": [5, 8, 3, 10, 6, 12, 4, 9, 7, 11, 8, 5, 10, 6] }";
            out.println(jsonData);
        }
    }

}
