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
@WebServlet("/FreeTrainingServlet")
public class FreeTrainingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeTrainingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // ボタンがクリックされたときに渡された positionId を取得
        String positionIdParam = request.getParameter("positionId");

        int positionId;

        if (positionIdParam != null) {
            // ボタンがクリックされた場合はその値を使う
            positionId = Integer.parseInt(positionIdParam);
        } else {
            // ボタンがクリックされていない場合はデフォルトの positionId を指定する
            positionId = 1;  // ここでは腕の positionId をデフォルトとしていますが、適切な値に変更してください
        }
		
		List<MuscleDTO> training = SampleMuscleDAO.selectTrainingByPosition(positionId);
		
		request.setAttribute("list", training);
		
		String view = "WEB-INF/view/free-training.jsp";
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
