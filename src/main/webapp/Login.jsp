<%@ page import="java.util.Objects" %>
<%@ page import="Modal.User" %>



<%
    User user = (User) request.getSession().getAttribute("currentUser");
    if (user != null){
        response.sendRedirect("Main.jsp");
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
    <%@ include file="Link_common.jsp" %>

    <style>
        body {
            width: 100vw;
            height: 100vh;
            background: #1e2a78;
        }
        .main_content{
            height: 100%;
        }
        .card{
            height: 60%;
            border-radius: 20px;
            background: transparent;
           border: 1px solid #86b7fe;

        }
        .card h3{
            color: #86b7fe;
        }
        .card-body img{
            height: 60px;
            width: 100px;
        }
        .login_form input{
            background: transparent;
            color: #86b7fe;
            border-color: #86b7fe;
        }
        .login_form input:focus{
            background: transparent !important;
            color: #86b7fe;
        }

        .login_form input:-webkit-autofill:active  {
            background: transparent !important;
        }
        input:-webkit-autofill,
        input:-webkit-autofill:focus,
        input:-webkit-autofill:active {
            transition: background-color 5000s ease-in-out 0s;
            -webkit-text-fill-color: #86b7fe !important;
        }
        .login_form button{
            background: transparent;
            color: #86b7fe;
            border-color: #86b7fe;
        }
        .login_form button:focus{
            background: transparent;
            color: #86b7fe;

        }
        .login_form button:hover{
            background: transparent;
            box-shadow:0 0 0 0.25rem rgb(13 110 253 / 25%);

        }
        .signup_text a{
            color: #5599f9;
            text-decoration: none;
            margin-right: 5px;
        }
        .signup_text span{
            color: #86b7fe;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="row main_content  justify-content-center align-items-center">
        <div class="col-md-4 col-sm-12 " >
            <div class="card m-4">
                <div class="card-body p-4">
                    <div class="row pt-4">
                        <div class="col-12 text-center"><img src="image/logo.svg" alt="User Icon"></div>
                        <div class="col-12 text-center"><h3>MyKeep</h3></div>

                    </div>
                    <div class="row pt-4">
                        <form class="login_form" action="login" method="post">
                            <div class="mb-4">
                                <input type="email" name="email" class="form-control" id="email" placeholder="Email">
                            </div>
                            <div class="mb-4">
                                <input type="password" name="password" class="form-control" id="password" placeholder="Password">
                            </div>
                            <div class="mb-3">
                                <button type="submit" class="form-control" id="submit" > Login</button>
                            </div>
                            <div class="mb-3 signup_text mt-5 d-flex justify-content-center align-items-center">
                                <a href="signUp.jsp">SignUp </a> <span> For MyKeep</span>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%
    if (Objects.equals(request.getParameter("isSignUpSuccess"), "true")) {
        response.sendRedirect("Login.jsp");
%>
<script>
    Swal.fire('Sign Up Successful.')
</script>
<%
    }
    if (Objects.equals(request.getSession().getAttribute("isLoginFailed"), "true")){
%>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Bad Credentials.',
        })
    </script>
<%
        request.getSession().removeAttribute("isLoginFailed");
    }
    if (Objects.equals(request.getSession().getAttribute("user_not_found"), "true")){
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'User not Found. SignUp First',
    })
</script>
<%
        request.getSession().removeAttribute("user_not_found");
    }
%>
</body>
</html>
