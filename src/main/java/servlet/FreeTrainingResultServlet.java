package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SampleMuscleDAO;
import dto.MuscleDTO;
import dto.UserDTO;

/**
 * Servlet implementation class FreeTrainingResultServlet
 */
@WebServlet("/FreeTrainingResultServlet")
public class FreeTrainingResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 	
    	int id = Integer.parseInt(request.getParameter("id"));
    	
    	MuscleDTO training = SampleMuscleDAO.SelectTrainingById(id);
    	
        // セッションからユーザー情報を取得
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
     	session.setAttribute("detail", training);
     	
        // ユーザー情報からメールアドレスを取得
        String userEmail = user.getMail();

     // 仮にUserDAOを使用している場合
        int userId = UserDAO.getUserIdByMail(userEmail);
        System.out.print(userId);
        // user_idをリクエスト属性として設定
        request.setAttribute("user_id", userId);	
		request.setAttribute("training", training);

        // 今回は遷移先のJSPに直接user_idを表示する例を示していますが、
        // 実際の利用に合わせて処理を追加してください。
        String view = "WEB-INF/view/training-result.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // doGetメソッドを呼び出して処理を共有
        doGet(request, response);
    }
}
