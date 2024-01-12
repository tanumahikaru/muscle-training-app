package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuizDAO;
import dto.Quiz;
import dto.UserDTO;

/**
 * Servlet implementation class QuizResultServlet
 */
@WebServlet("/QuizResultServlet")
public class QuizResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizResultServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO) session.getAttribute("user");
		
		int ans = Integer.parseInt(request.getParameter("ans"));
		int quizId = Integer.parseInt(request.getParameter("quizId"));
		Quiz quiz = QuizDAO.selectQuizById(quizId);
		int result = (ans == quiz.getCorrect()) ? 1 : 2;
		
		if (QuizDAO.selectQuizRecord(user.getId(), quizId)==0) {
			// レコードが空だったらINSERT
			QuizDAO.registerQuizRecord(user.getId(), quizId, result);
		} else {
			// 回答済みだったらUPDATE
			QuizDAO.updateQuizRecord(user.getId(), quizId, result);
		}
		
		request.setAttribute("result", result);
		request.setAttribute("quiz", quiz);
		
		String correct="";
		switch(quiz.getCorrect()) {
			case 1:
				correct=quiz.getChoices_1();
				break;
			case 2:
				correct=quiz.getChoices_2();
				break;
			case 3:
				correct=quiz.getChoices_3();
				break;
			case 4:
				correct=quiz.getChoices_4();
				break;
		}
		request.setAttribute("correct", correct);
		
		String view = "WEB-INF/view/quiz-result.jsp";
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
