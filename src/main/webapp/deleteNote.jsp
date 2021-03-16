<%@ page import="DAO.NoteDAO" %>
<%@ page import="Helper.ConnectionProvider" %>
<%@ page import="java.sql.SQLException" %>

<%

    NoteDAO dao = new NoteDAO(ConnectionProvider.getConnection());
    try {
        int i = dao.delete(Integer.valueOf(request.getParameter("id")));

        if (i>0){
            response.getWriter().print("done");
        }else {
            response.getWriter().print("error");
        }


    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }
%>