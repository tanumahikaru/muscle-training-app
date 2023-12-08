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

// Import statements remain the same

@WebServlet("/RecipeLogServlet")
public class RecipeLogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RecipeLogServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String positionIdParam = request.getParameter("category_Id"); // Change parameter name
        int positionId;

        if (positionIdParam != null && !positionIdParam.isEmpty()) {
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

        String view = "/WEB-INF/view/recipe-log.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
