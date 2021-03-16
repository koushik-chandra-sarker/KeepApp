<%@ page import="java.util.Objects" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up</title>
    <%@ include file="Link_common.jsp" %>
    <link rel="stylesheet" href="css/signup.css">

</head>
<body>
<div class="container">
    <div class="row main_content  justify-content-center align-items-center">
        <div class="col-md-4 col-sm-12 ">
            <div class="card m-4">
                <div class="card-body p-4">
                    <div class="row pt-4 mb-4">
                        <div class="col-12 d-flex justify-content-center align-items-center">
                            <img src="image/logo.svg" alt="User Icon">
                            <div class="title">MyKeep</div>
                        </div>
                        <div class="col-12 text-center d-flex justify-content-center align-items-center">
                            <div class="titleMain">Sign Up</div>
                        </div>
                    </div>
                    <div class="row pt-4">

                        <form class="login_form" action="SignUpProcess.jsp" method="post">
                            <div class="mb-4">
                                <input type="email" name="email" class="form-control" id="email" placeholder="Email">
                            </div>
                            <div class="mb-4">
                                <input type="text" name="name" class="form-control" id="name" placeholder="Name">
                            </div>
                            <div class="mb-4">
                                <input type="password" name="password" class="form-control" id="password"
                                       placeholder="Password">
                            </div>
                            <div class="mb-3">
                                <button type="submit" class="form-control" id="submit">Sign Up</button>
                            </div>
                            <div class="mb-3 login_text mt-5 d-flex justify-content-center align-items-center">
                                <span>Already have an Account?</span><a href="Login.jsp">Login</a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<%
    if (Objects.equals(request.getParameter("isSignUpFailed"), "true")) {
%>
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Something went wrong!',
        })
        window.location = "signUp.jsp"
    </script>
<%
    }
%>


</body>
</html>



