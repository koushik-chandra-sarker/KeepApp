
<%@ page import="Modal.Note" %>
<%@ page import="DAO.NoteDAO" %>
<%@ page import="Helper.ConnectionProvider" %>
<%@ page import="java.sql.SQLException" %>
<%
    System.out.println("eiisjdfoi");

    String id = request.getParameter("note_id");
    String title = request.getParameter("note_title");
    String body = request.getParameter("note_body");

    Note note = new Note(Integer.parseInt(id),title, body);
    System.out.println("nds "+note);



    NoteDAO dao = new NoteDAO(ConnectionProvider.getConnection());
    try {
        int i = dao.update(note);
        if (i>0){
            response.getWriter().print("done");
        }else{
            response.getWriter().print("error");
        }
    } catch (SQLException throwables){
        throwables.printStackTrace();
    }

%>