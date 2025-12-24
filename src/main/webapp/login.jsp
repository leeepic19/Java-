<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户注册/登录 - WSDC订餐系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .auth-container {
            max-width: 450px;
            width: 100%;
        }
        .auth-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            background: white;
        }
        .auth-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 40px 30px 30px;
            text-align: center;
        }
        .auth-header h2 {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .nav-pills {
            background: #f8f9fa;
            border-radius: 30px;
            padding: 5px;
            margin-bottom: 25px;
        }
        .nav-pills .nav-link {
            color: #6c757d;
            border-radius: 30px;
            padding: 10px 30px;
            transition: all 0.3s;
        }
        .nav-pills .nav-link.active {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 500;
            transition: transform 0.2s;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .kaptcha-container {
            position: relative;
        }
        .kaptcha-img {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .kaptcha-img:hover {
            transform: scale(1.05);
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .back-to-home {
            text-align: center;
            margin-top: 20px;
        }
        .back-to-home a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }
        .back-to-home a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="card auth-card">
            <div class="auth-header">
                <div class="mb-3">
                    <i class="fas fa-utensils fa-3x"></i>
                </div>
                <h2>WSDC 订餐系统</h2>
                <p class="mb-0">美食 · 便捷 · 贴心</p>
            </div>
            <div class="card-body p-4">
                <!-- Tab Navigation -->
                <ul class="nav nav-pills justify-content-center" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="login-tab" data-bs-toggle="pill" 
                                data-bs-target="#login" type="button" role="tab">
                            <i class="fas fa-sign-in-alt me-2"></i>登录
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="register-tab" data-bs-toggle="pill" 
                                data-bs-target="#register" type="button" role="tab">
                            <i class="fas fa-user-plus me-2"></i>注册
                        </button>
                    </li>
                </ul>

                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- 登录表单 -->
                    <div class="tab-pane fade show active" id="login" role="tabpanel">
                        <form id="loginForm">
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-user me-1"></i>用户名
                                </label>
                                <input type="text" class="form-control" name="user_name" required
                                       placeholder="请输入用户名">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-lock me-1"></i>密码
                                </label>
                                <input type="password" class="form-control" name="user_password" required
                                       placeholder="请输入密码">
                            </div>
                            <div class="row mb-3">
                                <div class="col-7">
                                    <label class="form-label">
                                        <i class="fas fa-shield-alt me-1"></i>验证码
                                    </label>
                                    <input type="text" class="form-control" name="kaptcha" required
                                           placeholder="请输入验证码">
                                </div>
                                <div class="col-5 kaptcha-container d-flex align-items-end">
                                    <img src="kaptcha" class="kaptcha-img w-100" 
                                         onclick="this.src='kaptcha?'+Math.random()" 
                                         title="点击刷新验证码" alt="验证码">
                                </div>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">记住我</label>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-sign-in-alt me-2"></i>立即登录
                            </button>
                        </form>
                    </div>

                    <!-- 注册表单 -->
                    <div class="tab-pane fade" id="register" role="tabpanel">
                        <form id="registerForm">
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-user me-1"></i>用户名 *
                                </label>
                                <input type="text" class="form-control" name="user_name" required
                                       placeholder="4-16位字母数字组合" pattern="[a-zA-Z0-9]{4,16}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-lock me-1"></i>密码 *
                                </label>
                                <input type="password" class="form-control" id="reg_password" 
                                       name="user_password" required
                                       placeholder="6-20位密码" minlength="6" maxlength="20">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-lock me-1"></i>确认密码 *
                                </label>
                                <input type="password" class="form-control" id="confirm_password" required
                                       placeholder="请再次输入密码">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-id-card me-1"></i>真实姓名
                                </label>
                                <input type="text" class="form-control" name="user_realname"
                                       placeholder="请输入真实姓名">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-venus-mars me-1"></i>性别
                                </label>
                                <select class="form-select" name="user_sex">
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-envelope me-1"></i>邮箱 *
                                </label>
                                <input type="email" class="form-control" name="user_mail" required
                                       placeholder="example@email.com">
                            </div>
                            <div class="row mb-3">
                                <div class="col-7">
                                    <label class="form-label">
                                        <i class="fas fa-shield-alt me-1"></i>验证码 *
                                    </label>
                                    <input type="text" class="form-control" name="kaptcha" required
                                           placeholder="请输入验证码">
                                </div>
                                <div class="col-5 kaptcha-container d-flex align-items-end">
                                    <img src="kaptcha" class="kaptcha-img w-100" 
                                         onclick="this.src='kaptcha?'+Math.random()" 
                                         title="点击刷新验证码" alt="验证码">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-user-plus me-2"></i>立即注册
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="back-to-home">
            <a href="index.jsp">
                <i class="fas fa-home me-1"></i>返回首页
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script>
    $(document).ready(function() {
        // 登录表单提交
        $('#loginForm').submit(function(e) {
            e.preventDefault();
            $.ajax({
                url: 'UserLoginServlet',
                type: 'POST',
                data: $(this).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert(response.message);
                        window.location.href = 'index.jsp';
                    } else {
                        alert(response.message);
                        // 刷新验证码
                        $('.kaptcha-img').click();
                    }
                },
                error: function() {
                    alert('登录请求失败，请检查网络连接');
                }
            });
        });

        // 注册表单提交
        $('#registerForm').submit(function(e) {
            e.preventDefault();
            
            // 验证密码
            var password = $('#reg_password').val();
            var confirmPassword = $('#confirm_password').val();
            if (password !== confirmPassword) {
                alert('两次输入的密码不一致！');
                return;
            }
            
            $.ajax({
                url: 'UserRegisterServlet',
                type: 'POST',
                data: $(this).serialize(),
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        alert(response.message);
                        // 切换到登录标签
                        $('#login-tab').click();
                        $('#registerForm')[0].reset();
                    } else {
                        alert(response.message);
                        // 刷新验证码
                        $('.kaptcha-img').click();
                    }
                },
                error: function() {
                    alert('注册请求失败，请检查网络连接');
                }
            });
        });
    });
    </script>
</body>
</html>
