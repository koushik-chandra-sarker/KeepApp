package Servlet;

import DAO.NoteDAO;
import Helper.ConnectionProvider;
import Modal.Note;
import Modal.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "addNoteServlet", urlPatterns = "/addNoteServlet")
@MultipartConfig
public class addNoteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String title = request.getParameter("note_title");
        String body = request.getParameter("note_body");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        Note note = new Note(title, body, user.getId());


        NoteDAO dao = new NoteDAO(ConnectionProvider.getConnection());
        try {
            var i = dao.saveData(note);
            if (i>0){
                response.getWriter().print("done");
            }else{
                response.getWriter().print("error");
            }
        } catch (SQLException throwables){
            throwables.printStackTrace();
        }

    }
}
