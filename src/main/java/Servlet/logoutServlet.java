package Servlet;




import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.io.IOException;

@WebServlet(name = "logoutServlet",urlPatterns = "/logout")
public class logoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        session.invalidate();
        response.sendRedirect("Login.jsp");
        response.setHeader("Cache-Control","no-cache,no-store,must-revalidate"); // HTTP v1.1
        response.setHeader("Pragma","no-cache"); // HTTP 1.0
        response.setHeader("Expires","0"); //Proxies server
    }


}
