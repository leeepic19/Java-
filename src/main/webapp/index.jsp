<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>网上订餐系统 - 首页</title>
    
    <!-- Original CSS to support Bean output -->
    <link type="text/css" href="css/public.css" rel="stylesheet"/>
    <link type="text/css" href="css/index.css" rel="stylesheet"/>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        /* Fix conflicts between Bootstrap and original CSS if any */
        ul {
            padding-left: 0; /* Reset padding for uls */
            list-style: none;
        }
        a {
            text-decoration: none;
        }
        /* Ensure the generated li elements float or grid properly if the original CSS relied on floats */
        .text {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .content {
            margin: 10px;
        }
    </style>
</head>
<body>
    <jsp:useBean id="user" scope="session" class="vo.Person"></jsp:useBean>
    <jsp:useBean id="menuBean" scope="page" class="vo.Menu"></jsp:useBean>
    <jsp:useBean id="introduceBean" scope="page" class="vo.Introduce"></jsp:useBean>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-utensils me-2"></i>WSDC 订餐系统
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">首页</a></li>
                    <li class="nav-item"><a class="nav-link" href="shopping.jsp">购物车</a></li>
                    <li class="nav-item"><a class="nav-link" href="order_search.jsp">我的订单</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">关于我们</a></li>
                </ul>
                <div class="d-flex align-items-center text-white">
                    <c:choose>
                        <c:when test="${user.user_name!=null}">
                            <div class="dropdown">
                                <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${user.user_name}
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="MemberServlet">个人中心</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="UserExitServlet">退出登录</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="register.jsp" class="btn btn-outline-light me-2">注册</a>
                            <a href="register.jsp" class="btn btn-primary">登录</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section / Banner -->
    <div class="container-fluid p-0 mb-4">
        <div style="background: url('images/banner.jpg') no-repeat center center; background-size: cover; height: 300px; display: flex; align-items: center; justify-content: center; color: white; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">
            <h1>欢迎来到 WSDC 订餐系统</h1>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <!-- Left Sidebar (Search & Intro) -->
            <div class="col-md-3">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <i class="fas fa-search me-2"></i>搜索
                    </div>
                    <div class="card-body">
                        <div class="input-group">
                            <input type="text" class="form-control" id="research" placeholder="搜索菜品...">
                            <button class="btn btn-outline-primary" type="button"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <i class="fas fa-store me-2"></i>商家介绍
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            <jsp:getProperty property="showIntroduce" name="introduceBean"/>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <!-- Daily Recommendations -->
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <i class="fas fa-star me-2"></i>每日推荐
                    </div>
                    <div class="card-body">
                        <ul class="text">
                            <jsp:getProperty property="showMenuTop" name="menuBean"/>
                        </ul>
                    </div>
                </div>

                <!-- All Menu Items -->
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <i class="fas fa-list me-2"></i>全部菜品
                    </div>
                    <div class="card-body">
                        <ul class="text">
                            <jsp:getProperty property="showMenuList" name="menuBean"/>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-4">
        <p>&copy; 2025 WSDC 订餐系统. All rights reserved.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
