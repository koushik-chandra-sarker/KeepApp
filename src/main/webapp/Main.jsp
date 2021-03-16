<%@ page import="java.time.LocalDate" %>
<%@ page import="Modal.User" %>
<%@ page import="DAO.NoteDAO" %>
<%@ page import="Helper.ConnectionProvider" %>
<%@ page import="Modal.Note" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (User) request.getSession().getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("Login.jsp");
    }
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate"); // HTTP v1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setHeader("Expires","0"); //Proxies server

%>


<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>MyKeep</title>
    <%@include file="Link_common.jsp" %>
    <link rel="stylesheet" href="css/main.css">
    <style>
        .header_content{
            width: 100%;
        }
        .header_content span{
            color: #02FD97;
            font-size: 18px;

        }
        .logout_btn{
            border: 2px solid #02FD97;
            color: #02FD97;
            margin-left: 10px;
            background: none;
            padding: 2px 5px;
            border-radius: 5px;
        }
        .logout_btn:hover{
            color: #a9fad5;
            border-color: #a9fad5;
        }
        .logout_btn:active{
            box-shadow: #20df79;
        }
    </style>
</head>
<body>

<header>
    <div class="row navbar header_content d-flex justify-content-between">
        <div class="col d-flex">
            <img src="image/logo_yellow.svg" alt="logo" width="100px" height="50px">
            <h1>MyKeep</h1>
        </div>
        <div class="col d-flex justify-content-end">
            <span><%=user.getName()%></span>
            <a href="logout"><button type="button" class=" logout_btn">Logout</button></a>
        </div>
    </div>

</header>
<main class="container">
    <section>
        <div class="row">

            <div class="col-md-6 mt-4 offset-md-3 col-sm-12 take_note">
                <div class="card">
                    <form id="addNoteForm">
                        <input class="form-control note_title" type="text" name="note_title" placeholder="Title">
                        <textarea class="form-control note_body" rows="1" name="note_body"
                                  placeholder="Take a note..."></textarea>
                        <div class="add_button">
                            <button type="submit"><i class="fas fa-plus"></i></button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </section>

    <section>
        <div class="row mt-4 " id="note_container">
<%--        load from load_note.jsp with javascript--%>
        </div>
    </section>

</main>

<section class="edit_modal">
    <!-- Modal -->
    <div class="modal fade" id="editModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Edit Note</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editNoteForm">
                    <div class="modal-body">
                        <input class="form-control edit_note_id" type="text" name="note_id" contenteditable="false">
                        <input class="form-control edit_note_title" type="text" name="note_title">
                        <textarea class="form-control edit_note_body" name="note_body"
                        ></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" >Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


</section>


<footer>
    <p>copyright &copy <%= LocalDate.now().getYear() %> - Koushik</p>
</footer>


<script>

    const note_title = document.querySelector(".note_title")
    const note_body = document.querySelector(".note_body")
    const add_button = document.querySelector(".add_button")

    document.querySelector(".note_body").addEventListener("focusin", evt => {
        note_title.classList.add("active_note_title");
        add_button.classList.add("active")
    })


    document.querySelector(".note_body").addEventListener("focusout", evt => {
        if (note_body.value === "") {
            note_title.classList.remove("active_note_title");
            add_button.classList.remove("active")
        }
    })

</script>

<script>

    function getAllNote() {
        $.ajax({
            url: "load_note.jsp",
            success: function (data) {
                $("#note_container").html(data);
            }
        })
    }

    function deleteNote(noteId) {
        $.ajax({
            url: "deleteNote.jsp",
            data: {id: noteId},
            success: function (data) {
                if (data.trim() === "done") {
                    Swal.fire({
                        position: 'top-end',
                        icon: 'success',
                        title: 'Your work has been saved',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    getAllNote()
                }
            }
        })
    }


    function showEditModal(id, title, body) {
        $('#editNoteForm .edit_note_id').val(id)
        $('#editNoteForm .edit_note_title').val(title)
        $('#editNoteForm .edit_note_body').val(body)

    }

    $(document).ready(function () {

        /*get All Notes when document open First*/
        getAllNote()


        /*Add Note*/
        $('#addNoteForm').submit(function (event) {
            event.preventDefault();

            //get form Data when submitted
            let formData = new FormData(this);

            // send formData through "AJAX" and receive response
            $.ajax({
                url: "addNoteServlet",
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    if (data.trim() === 'done') {

                        //empty title and body fields
                        $(".note_title").val('')
                        $(".note_body").val('')

                        getAllNote() // after adding a new note get all updated notes

                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Your Note has been saved',
                            showConfirmButton: false,
                            timer: 1500
                        });

                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Something went wrong!',
                        })
                    }
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!',
                    })
                },
            })

        });



        /*Edit Note*/
        $('#editNoteForm').submit(function (event) {
            event.preventDefault();

            let formData = new FormData(this);
            console.log(formData.get("note_id"))
            $.ajax({
                url: "updateNote.jsp",
                data: {
                    note_id:formData.get("note_id"),
                    note_title:formData.get("note_title"),
                    note_body:formData.get("note_body"),
                },
                // data:formData,
                // type: "post",
                // processData: false,
                // contentType: false,
                success: function (data) {
                    if (data.trim() === 'done') {
                        getAllNote()

                        //show alert
                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Your Note has been Updated.',
                            showConfirmButton: false,
                            timer: 1500
                        });

                        //hide edit modal
                        $('#editModal').modal('hide');

                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Something went wrong!...',
                        })
                    }
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Something went wrong!===',
                    })
                },
            })

        });

    });
</script>
</body>
</html>