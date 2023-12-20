package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.Meal_menuDAO;
import dao.MuscleDAO;
import dao.MuscleRecordDAO;
import dao.UserDAO;
import dto.MuscleRecord;
import dto.UserDTO;
import util.GenerateHashedPw;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getParameter("UTF-8");

		String mail = request.getParameter("mail");
		String pw = request.getParameter("pw");

		// 入力されたIDをもとにソルトを取得する。
		String salt = UserDAO.getSalt(mail);

		

		// 取得したソルトがnullの場合は対象のユーザがいないので、Errorでログイン画面に戻す
		if (salt == null) {
			String view = "/?error=1"; // URLはhttp://localhost:8080/MuscleTrainingApp/という意味
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			return;
		}

		
		
		// 取得したソルトを使って入力したPWをハッシュ化
		String hashedPw = GenerateHashedPw.getSafetyPassword(pw, salt);


		
		// 入力されたID、ハッシュ化したPWに一致するユーザを検索する
		UserDTO user = UserDAO.login(mail, hashedPw);



		if (user == null) {
			// ログイン失敗時index.htmlを表示
			String view = "/?error=1";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		} else
  	    {
			// ログイン成功時の処理
			// 初回ログインかどうかの判定
			String today = new java.sql.Date(new java.util.Date().getTime()).toString(); // 現在日時を取得
			String lastLogin = new java.sql.Date(user.getLast_login().getTime()).toString();
			
			System.out.println(lastLogin);
			System.out.println(today);

            // ログイン情報をセッションに登録
			  HttpSession session = request.getSession();
	          session.setAttribute("user", user);
	          
			System.out.println(lastLogin);
			System.out.println(today);
			
			if (!lastLogin.equals(today)) {
				System.out.println("初回ログイン！");

				// 今日のトレーニングプログラムIDを取得
				List<Integer> preTrainingRecords = MuscleRecordDAO.selectPreviousMuscleRecords(user.getId());

				// 前回トレーニングしたときに指定されたトレーニングプログラムを行っていたら更新する
				if (preTrainingRecords.contains(user.getTraining_program_id())) {
					// 今日のトレーニングIDを決める
					int todaysTrainingProgramId = 0;
					if (MuscleDAO.nextTrainingProgramId(user.getTraining_program_id()) != 0) { // 次のトレーニングプログラムIDを取得出来たらそれを使う
						todaysTrainingProgramId = MuscleDAO.nextTrainingProgramId(user.getTraining_program_id());
					} else { // 次のトレーニングプログラムIDを取得出来なかったら(IDが最大だったら)トレーニングプログラムIDで最小のものを採用
						todaysTrainingProgramId = MuscleDAO.minTrainingProgramId();
					}
					System.out.println("トレプロID" + todaysTrainingProgramId);
					if(MuscleDAO.updateTrainingProgramId(todaysTrainingProgramId, user.getId()) == 1){
						user.setTraining_program_id(todaysTrainingProgramId);
					}
				}

				// 今日の食事メニューをランダムで選択し、更新する
				List<Integer> foodIdList = Meal_menuDAO.selectAllMainDishesId();
				Random rand = new Random();
				int foodId = rand.nextInt(foodIdList.size());
				System.out.println("食事メニューID" + foodId);
				if(Meal_menuDAO.updateFoodId(foodId, user.getId()) == 1) {
					user.setFood_id(foodId);
				}
				
				// 最終ログイン日を更新する
				UserDAO.updateLastLogin(user.getId());
				
			}

			MuscleRecord latestRecord = MuscleRecordDAO.selectLatestMuscleRecord();
			
					
			if (latestRecord != null) {
				System.out.println("latestRecord != null >> " + latestRecord.getUser_id() + "<<");
				
				request.setAttribute("latestRecord", latestRecord);
			}
			

			// ログイン後のホーム画面へ遷移
			String view = "WEB-INF/view/home.jsp";			
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			
System.out.println( "dispather");

			dispatcher.forward(request, response);
		
		}
	
		
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
