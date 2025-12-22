<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户注册/登录 - 网上订餐系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .auth-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .auth-header {
            background: linear-gradient(135deg, #0d6efd, #0a58ca);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .nav-pills .nav-link {
            color: #6c757d;
            border-radius: 30px;
            padding: 10px 25px;
        }
        .nav-pills .nav-link.active {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card auth-card">
                    <div class="auth-header">
                        <h3><i class="fas fa-utensils me-2"></i>WSDC 订餐系统</h3>
                        <p class="mb-0">欢迎回来，请登录或注册新账号</p>
                    </div>
                    <div class="card-body p-4">
                        <ul class="nav nav-pills nav-fill mb-4" id="pills-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-login-tab" data-bs-toggle="pill" data-bs-target="#pills-login" type="button">登录</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-register-tab" data-bs-toggle="pill" data-bs-target="#pills-register" type="button">注册</button>
                            </li>
                        </ul>
                        
                        <div class="tab-content" id="pills-tabContent">
                            <!-- Login Form -->
                            <div class="tab-pane fade show active" id="pills-login">
                                <form action="UserLoginServlet" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">用户名</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" name="username" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">密码</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                            <input type="password" name="password" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">身份</label>
                                        <select name="flag" class="form-select">
                                            <option value="2">普通用户</option>
                                            <option value="1">管理员</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100 py-2">立即登录</button>
                                </form>
                            </div>
                            
                            <!-- Register Form -->
                            <div class="tab-pane fade" id="pills-register">
                                <form action="UserRegisterServlet" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">用户名</label>
                                        <input type="text" name="username" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">密码</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">确认密码</label>
                                        <input type="password" name="repassword" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">真实姓名</label>
                                        <input type="text" name="realname" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">性别</label>
                                        <select name="sex" class="form-select">
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">邮箱</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <button type="submit" class="btn btn-success w-100 py-2">注册账号</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="index.jsp" class="text-decoration-none text-muted"><i class="fas fa-arrow-left me-1"></i>返回首页</a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
