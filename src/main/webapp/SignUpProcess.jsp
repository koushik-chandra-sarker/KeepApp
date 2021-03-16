
<%@ page import="DAO.UserDAO" %>
<%@ page import="Helper.ConnectionProvider" %>
<%@ page import="Modal.User" %>

<%

    UserDAO dao = new UserDAO(ConnectionProvider.getConnection());

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    int i = 0;
    try {
        i = dao.saveData(new User(name, email, password));
    } catch (Exception E) {
        E.printStackTrace();
    }
    if (i > 0) {
%>

<jsp:forward page="Login.jsp" >
    <jsp:param name="isSignUpSuccess" value="true"/>
</jsp:forward>
<%
} else {
%>
<jsp:forward page="signUp.jsp" >
    <jsp:param name="isSignUpFailed" value="true"/>
</jsp:forward>
<%
    }
%>

