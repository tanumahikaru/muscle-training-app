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
 * Servlet implementation class SearchTrainingServlet
 */
@WebServlet("/SearchTrainingServlet")
public class SearchTrainingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchTrainingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
		
		// 検索キーワードを取得
        String searchKeyword = request.getParameter("searchKeyword");
        System.out.println("Search Keyword: " + searchKeyword);

        // DAOメソッドに検索キーワードを渡して結果を取得
        List<MuscleDTO> training;
        
        int defaultCategoryId = 1;
        
        String positionName = SampleMuscleDAO.getPositionNameById(defaultCategoryId);
        
     // カテゴリ名がnullの場合、検索時のメッセージを設定
        if (positionName == null || searchKeyword != null && !searchKeyword.isEmpty()) {
            positionName = "検索";
        }
        
        request.setAttribute("positionName", positionName);
        
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            // 検索キーワードがある場合は検索を実行
            training = SampleMuscleDAO.searchTrainingByName(searchKeyword);
            if (training == null || training.isEmpty()) {
                positionName = "検索した";
                request.setAttribute("positionName", positionName);
            }
        } else {
            // 検索キーワードがない場合はデフォルトのカテゴリーで検索
            int defaultPositionId = 1;  // デフォルトのポジションID（腕）を指定
            training = SampleMuscleDAO.selectTrainingByPosition(defaultPositionId);
        }

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
