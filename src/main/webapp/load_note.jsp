<%@ page import="Modal.User" %>
<%@ page import="DAO.NoteDAO" %>
<%@ page import="Helper.ConnectionProvider" %>
<%@ page import="Modal.Note" %>
<%@ page import="java.util.List" %>


<%
    User user = (User) request.getSession().getAttribute("currentUser");
    NoteDAO dao = new NoteDAO(ConnectionProvider.getConnection());
    List<Note> notes = null;
    if (user != null) {
        notes = dao.getAllByUserId(user.getId());
        for (Note note : notes) {

%>
<div class="col-md-4 col-lg-3 mb-2">
    <div class="col-12 card">
        <div class="card-body">
            <h5 class="card-title"><%=note.getTitle()%>
            </h5>
            <p class="card-text"><%=note.getBody()%>
            </p>
            <div class="note_button d-flex">
                <button onclick="showEditModal('<%=note.getId()%>','<%=note.getTitle()%>','<%=note.getBody()%>')" class="edit_button" data-bs-toggle="modal" data-bs-target="#editModal"><i
                        class="fas fa-pencil-alt"></i></button>
                <button onclick="deleteNote(<%=note.getId()%>)" class="delete_button" type="submit"><i
                        class="far fa-trash-alt"></i>
                </button>
            </div>
        </div>
    </div>
</div>
<%
        }
    }
%>


