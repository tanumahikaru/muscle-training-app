package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MuscleRecordDAO;
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
    	//各セットの回数の値を取得
    	int numberSet1 = Integer.parseInt(request.getParameter("numberSet1"));
        int numberSet2 = Integer.parseInt(request.getParameter("numberSet2"));
        int numberSet3 = Integer.parseInt(request.getParameter("numberSet3"));
    	
        // 各セットのタイマーの値を取得
        String timerValue1 = request.getParameter("timerValue1");
        String timerValue2 = request.getParameter("timerValue2");
        String timerValue3 = request.getParameter("timerValue3");
        
        double double_timerValue1 = Double.parseDouble(timerValue1);
        double double_timerValue2 = Double.parseDouble(timerValue2);
        double double_timerValue3 = Double.parseDouble(timerValue3);
        
        
    	HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        MuscleDTO training = (MuscleDTO) session.getAttribute("detail");
        
        
        // ユーザーオブジェクトからユーザーIDを取得
        int userId = user.getId();
        
        // トレーニングオブジェクトからトレーニングイベントIDを取得
        int trainingEventId = training.getTraining_event_id();
        
        // それぞれをリクエスト属性として設定
        request.setAttribute("user_id", userId);
        request.setAttribute("training_event_id", trainingEventId);
        
        //ユーザIDをもとに体重の記録を取得
        double weight = MuscleRecordDAO.getWeightByUserId(userId);
        
        
        //トレーニングイベントIDをもとにmetsを取得
        int mets = MuscleRecordDAO.getMetsByTrainingEventId(trainingEventId);
       
        
        
        
        //1セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet1, double_timerValue1, weight, mets);
        //2セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet2, double_timerValue2, weight, mets);
        //3セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet3, double_timerValue3, weight, mets);
        
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
