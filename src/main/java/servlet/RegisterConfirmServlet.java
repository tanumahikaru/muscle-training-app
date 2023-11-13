package servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.UserDTO;
import dto.WeightDTO;

@WebServlet("/RegisterConfirmServlet")
public class RegisterConfirmServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterConfirmServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String genderStr = request.getParameter("gender");
        String birthStr = request.getParameter("birth");
        String heightStr = request.getParameter("height");
        String weightStr = request.getParameter("weight");
        String mail = request.getParameter("mail");
        String password = request.getParameter("password");
        String lastLoginStr = request.getParameter("last_login"); // パラメータ名を修正
        
        System.out.print(name);
        System.out.print(genderStr);
        System.out.print(birthStr);
        System.out.print(heightStr);
        System.out.print(weightStr);
        System.out.print(mail);
        System.out.print(password);
        System.out.print(lastLoginStr);
        
        int gender = Integer.parseInt(genderStr);
        float height = Float.parseFloat(heightStr);
        float weight = Float.parseFloat(weightStr);
        
        try {
            Date birth = new SimpleDateFormat("yyyy-MM-dd").parse(birthStr);
            Date registrationDate = new Date(); // 現在の日時を取得
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String registrationDateStr = dateFormat.format(registrationDate);

            // ... (他のパラメータの取得)

            UserDTO user = new UserDTO(-1, name, gender, birth, height, mail, null, password, null, -1, -1, -1, registrationDate);
            WeightDTO we = new WeightDTO(-1, weight);

            // ... (セッションへの保存とフォワードの処理)

            // セッションスコープのインスタンス取得
            HttpSession session = request.getSession();
            
            // セッションスコープに値の保存
            session.setAttribute("input_data", user);
            session.setAttribute("weight_data", we);
            
            String view = "WEB-INF/view/register-user-confirm.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(view);
            dispatcher.forward(request, response);    
        } catch (ParseException e) {
            // パースエラーが発生した場合の処理を記述
            e.printStackTrace(); // または適切なエラーメッセージをログに記録
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
