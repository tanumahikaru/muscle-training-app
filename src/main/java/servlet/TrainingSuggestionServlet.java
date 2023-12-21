package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MuscleDAO;
import dto.MuscleDTO;
import dto.UserDTO;

/**
 * Servlet implementation class TrainingSuggestionServlet
 */
@WebServlet("/TrainingSuggestionServlet")
public class TrainingSuggestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrainingSuggestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user"); 
		int training_program_id = user.getTraining_program_id();  // 本当は今日のトレーニングプログラムを書く
		System.out.println(training_program_id);
		ArrayList<MuscleDTO> training = (ArrayList<MuscleDTO>) MuscleDAO.selectTrainingsByTrainingProgram(training_program_id);
		
		session.setAttribute("training_list", training);
//		request.setAttribute("list", training);
		
		String view = "WEB-INF/view/training_suggestion.jsp";
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
