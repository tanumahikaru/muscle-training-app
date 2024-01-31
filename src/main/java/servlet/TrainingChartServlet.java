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
import dao.SampleMuscleDAO;
import dto.MuscleDTO;
import dto.UserDTO;

/**
 * Servlet implementation class TrainingServlet
 */
@WebServlet("/TrainingChartServlet")
public class TrainingChartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrainingChartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            MuscleDTO training = SampleMuscleDAO.SelectTrainingById(id);

            // セッションとリクエストに属性を設定
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");

            int userId = user.getId();
            int trainingEventId = training.getTraining_event_id();

            // トレーニングの統計データを取得
            int totalNumber = MuscleRecordDAO.calculateTotalNumber(userId, trainingEventId);
            int totalSetNumber = MuscleRecordDAO.getRecordCountByUserAndEvent(userId, trainingEventId);
            int maxNumber = MuscleRecordDAO.getMaxNumber(userId, trainingEventId);
            int minNumber = MuscleRecordDAO.getMinNumber(userId, trainingEventId);
            int avgNumber = (int) MuscleRecordDAO.getAverageNumber(userId, trainingEventId);
            int totalCalories_burned = (int) MuscleRecordDAO.getTotalCaloriesBurned(userId, trainingEventId);

            // トレーニングデータをJSPに転送
            request.setAttribute("training2", training);
            request.setAttribute("totalNumber", totalNumber);
            request.setAttribute("totalSetNumber", totalSetNumber);
            request.setAttribute("maxNumber", maxNumber);
            request.setAttribute("minNumber", minNumber);
            request.setAttribute("avgNumber", avgNumber);
            request.setAttribute("totalCalories_burned", totalCalories_burned);


            // JSPにフォワード
            String view = "WEB-INF/view/training-chart.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	private List<Double> getWeightDataFromDatabase(int id) {
		// TODO 自動生成されたメソッド・スタブ
		return null;
	}

	private int calculateTotalNumber(int userId, int trainingEventId) {
		// TODO 自動生成されたメソッド・スタブ
		return 0;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}