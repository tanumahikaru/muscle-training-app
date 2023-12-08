package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.UserDTO;

/**
 * Servlet implementation class FreeTrainingResultServlet
 */
@WebServlet("/FreeTrainingResultServlet")
public class FreeTrainingResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 	
    	
    	HttpSession session = request.getSession();
    	UserDTO user = (UserDTO) session.getAttribute("user");

    	    // ユーザーオブジェクトからユーザーIDを取得
    	    int userId = user.getId();

    	    // 取得したユーザーIDをリクエスト属性として設定
    	    request.setAttribute("user_id", userId);
    	    System.out.print(userId);

    	    // training_event_idをリクエストパラメータから取得
    	    int trainingEventId = Integer.parseInt(request.getParameter("training_event_id"));
    	    System.out.print(trainingEventId);
    	    
    	    // 取得したtraining_event_idをリクエスト属性として設定
    	    request.setAttribute("training_event_id", trainingEventId);
    	    System.out.print(trainingEventId);
        
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
