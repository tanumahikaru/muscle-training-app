package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SampleMuscleDAO;
import dto.MuscleDTO;

/**
 * Servlet implementation class FreeTrainingServlet
 */
@WebServlet("/TrainingLogServlet")
public class TrainingLogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrainingLogServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String positionIdParam = request.getParameter("positionId");
        int positionId;

        if (positionIdParam != null) {
            positionId = Integer.parseInt(positionIdParam);
        } else {
            positionId = 1;
        }

        List<MuscleDTO> training = SampleMuscleDAO.selectTrainingByPosition(positionId);
        String positionName = SampleMuscleDAO.getPositionNameById(positionId);

        if (positionName == null) {
            positionName = "検索した";
        }

        request.setAttribute("list", training);
        request.setAttribute("positionName", positionName);

        String view = "/WEB-INF/view/training-log.jsp";
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
