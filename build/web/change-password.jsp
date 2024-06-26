<%-- 
    Document   : forgot-password
    Created on : May 27, 2024, 1:26:34 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin 2 - Forgot Password</title>

        <!-- Custom fonts for this template-->
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">

    </head>

    <body class="bg-gradient-primary">

        <div class="container">

            <!-- Outer Row -->
            <div class="row justify-content-center">

                <div class="col-xl-10 col-lg-12 col-md-9">

                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <!-- Nested Row within Card Body -->
                            <div class="row">
                                <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                                <div class="col-lg-6">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                                            <p class="mb-4">We get it, stuff happens. Just enter your email address below
                                                and we'll send you a link to reset your password!</p>
                                        </div>
                                        <form action="#" method="post" class="user">
                                            <div class="form-group">
                                                <input type="password" name="old" class="form-control form-control-user"
                                                       placeholder="Enter Old Password...">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="newP" class="form-control form-control-user"
                                                       placeholder="Enter New Password...">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="conP" class="form-control form-control-user"
                                                       placeholder="Enter Confirm Password...">
                                            </div>
                                            <div class="form-group" style="text-align: center">
                                                <c:if test="${err}">
                                                    <p style="color: red">${err}</p>
                                                </c:if>
                                                <c:if test="${suc}">
                                                    <p style="color: green">${suc}</p>
                                                </c:if>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-user btn-block">
                                                Change Password
                                            </button>
                                        </form>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="login">Already have an account? Login!</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <script>
            let suc = "${suc}";
            if (suc !== "") {
                setTimeout(function () {
                    window.location.href = 'logout';
                }, 3000);
            }
        </script>
        <!-- Bootstrap core JavaScript-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin-2.min.js"></script>

    </body>

</html>
