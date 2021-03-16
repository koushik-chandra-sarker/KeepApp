package Servlet;

import DAO.UserDAO;
import Helper.ConnectionProvider;
import Modal.User;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Objects;


@WebServlet(name = "loginServlet",urlPatterns = "/login")
public class loginServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
        User user = dao.getByEmail(email);
        System.out.println(user);
        HttpSession session = request.getSession();
        if (user != null){
            if (Objects.equals(user.getPassword(), pass)){
                session.setAttribute("currentUser",user);
                response.sendRedirect("Main.jsp");
                response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
                response.setHeader("Pragma","no-cache"); // HTTP 1.0
                response.setHeader("Expires","0"); //Proxies server
            }else {
                session.setAttribute("isLoginFailed","true");
                response.sendRedirect("Login.jsp");
            }
        }
        else {
            session.setAttribute("user_not_found","true");
            response.sendRedirect("Login.jsp");
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }
}
  