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
        int id = Integer.parseInt(request.getParameter("id"));
        
        MuscleDTO training = SampleMuscleDAO.SelectTrainingById(id);
        
        // 合計回数を計算
        int userId = 1; // 適切なユーザーIDを設定する必要があります
        int trainingEventId = id; // ここではトレーニングイベントIDを使用していると仮定しています

        int totalNumber = calculateTotalNumber(userId, trainingEventId);

        // セッションとリクエストに属性を設定
        HttpSession session = request.getSession();
        session.setAttribute("detail", training);
        request.setAttribute("training", training);
        request.setAttribute("totalNumber", totalNumber);

        String view = "WEB-INF/view/training-chart.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
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
