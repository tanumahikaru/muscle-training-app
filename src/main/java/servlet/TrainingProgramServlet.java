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
import dto.MuscleDTO;
import dto.UserDTO;

/**
 * Servlet implementation class TrainingProgramServlet
 */
@WebServlet("/TrainingProgramServlet")
public class TrainingProgramServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrainingProgramServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("doGet method is called.");  // 追加した行

    	
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
        
        
    	HttpSession session = request.getSession(true);
        UserDTO user = (UserDTO) session.getAttribute("user");
        MuscleDTO training = (MuscleDTO) session.getAttribute("detail");
        
        
        // ユーザーオブジェクトからユーザーIDを取得
        int userId = user.getId();
        
        // トレーニングオブジェクトからトレーニングイベントIDを取得
        int trainingEventId = training.getTraining_event_id();
        System.out.println("トレーニングID:"+trainingEventId);
        String eventName = MuscleRecordDAO.getEventNameById(trainingEventId);
        System.out.println("Event Name: " + eventName);
        // それぞれをリクエスト属性として設定
        request.setAttribute("event_name", eventName);
        request.setAttribute("user_id", userId);
        request.setAttribute("training_event_id", trainingEventId);
        
        //ユーザIDをもとに体重の記録を取得
        double weight = MuscleRecordDAO.getWeightsByUserId(userId).get(0);
        
        //トレーニングイベントIDをもとにmetsを取得
        int mets = MuscleRecordDAO.getMetsByTrainingEventId(trainingEventId);
        
        //1セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet1, double_timerValue1, weight, mets);
        //2セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet2, double_timerValue2, weight, mets);
        //3セット目の値をデータベースに挿入
        MuscleRecordDAO.insertTrainingRecord(userId, trainingEventId, numberSet3, double_timerValue3, weight, mets);
        
        List<Double> last3Calories = MuscleRecordDAO.selectLast3Calories(userId);
        
        // 下から3件の消費カロリーの合計を取得
        double totalCalories = MuscleRecordDAO.getTotalCaloriesLast3(userId);

        // リクエスト属性としてJSPに渡す
        request.setAttribute("totalCaloriesLast3", totalCalories);
        
        int trIndex = (int)session.getAttribute("trIndex");
        trIndex++;
		session.setAttribute("trIndex", trIndex);
		System.out.println(trIndex);
		
        String view = "/NextTrainingServlet";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
