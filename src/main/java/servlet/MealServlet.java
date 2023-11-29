package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/MealServlet")
public class MealServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String mealName = (String) session.getAttribute("mealName");
        String mealDescription = (String) session.getAttribute("mealDescription");

        request.setAttribute("mealName", mealName);
        request.setAttribute("mealDescription", mealDescription);

        request.getRequestDispatcher("WEB-INF/view/meal-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mealName = request.getParameter("mealName");
        String mealDescription = request.getParameter("mealDescription");

        HttpSession session = request.getSession();

        session.setAttribute("mealName", mealName);
        session.setAttribute("mealDescription", mealDescription);

        response.sendRedirect("MealServlet");
    }
}
