package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MuscleDAO;
import dao.SampleMuscleDAO;
import dto.ExplanationDTO;
import dto.MuscleDTO;
import dto.MuscleRecord;
import dto.UserDTO;

/**
 * Servlet implementation class NextTrainingServlet
 */
@WebServlet("/NextTrainingServlet")
public class NextTrainingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NextTrainingServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		ArrayList<MuscleDTO> training_menus = (ArrayList<MuscleDTO>) session.getAttribute("training_list");
		MuscleDTO training = null;
		
		int trIndex = (int)session.getAttribute("trIndex");
		
		if (trIndex == 5) {
			List<MuscleRecord> result = MuscleDAO.selectTodaysTrainingRecords(user.getId());
			request.setAttribute("result", result);
			
	        String view = "WEB-INF/view/todays-training-result.jsp";
	        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
	        dispatcher.forward(request, response);
	        return;
		} else {
			training = training_menus.get(trIndex);
			System.out.println(training.getTraining_event_id());
		}

		int trainingEventId = training.getTraining_event_id();
		List<ExplanationDTO> ex = SampleMuscleDAO.selectExplanationById(trainingEventId);
		
		session.setAttribute("detail", training);
		request.setAttribute("explanation", ex);
		request.setAttribute("training", training);
		
        String view = "WEB-INF/view/todays-training.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
