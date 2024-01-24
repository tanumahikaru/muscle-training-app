package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.Meal_RecordDAO;
import dto.Meal_RecordDTO;
import dto.UserDTO;

// Import statements remain the same

@WebServlet("/RecipeLogServlet")
public class RecipeLogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RecipeLogServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // セッションからユーザーIDを取得
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        int userId = user.getId();

        // 選択された日付を取得（デフォルトは今日の日付）
        String selectedDate = request.getParameter("selectedDate");
        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = LocalDate.now().toString();
        }

        // Meal_RecordDAO クラスを利用して選択された日に追加された食事のデータを取得
        Meal_RecordDAO mealRecordDAO = new Meal_RecordDAO();
        List<Meal_RecordDTO> mealsAddedOnSelectedDay = mealRecordDAO.getMealRecordsByDate(userId, selectedDate);

        // 選択された日付と食事データをリクエスト属性に設定
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("mealsAddedOnSameDay", mealsAddedOnSelectedDay);

        // JSPにフォワード

        String view = "/WEB-INF/view/recipe-log.jsp";
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
