<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page language="java" contentType="text/html; charset=UTF-8"

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    pageEncoding="UTF-8"%>

<!DOCTYPE html><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="zh-CN"><!DOCTYPE html>

<head><html lang="en">

    <meta charset="UTF-8">    <head>

    <meta name="viewport" content="width=device-width, initial-scale=1">        <meta charset="UTF-8">

    <title>网上订餐系统 - 首页</title>        <title>网上订餐系统--首页</title>

    <!-- Bootstrap CSS -->        <link type="text/css" href="css/public.css" rel="stylesheet"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">        <link type="text/css" href="css/index.css" rel="stylesheet"/>

    <!-- Font Awesome -->    </head>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">    <body>

    <style>    	<jsp:useBean id="user" scope="session" class="vo.Person"></jsp:useBean>

        .hero-section {    	<jsp:useBean id="menuBean" scope="page" class="vo.Menu"></jsp:useBean>

            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('images/banner.jpg');    	<jsp:useBean id="introduceBean" scope="page" class="vo.Introduce"></jsp:useBean>

            background-size: cover;        <div id="whole">

            background-position: center;            <div id="head">

            color: white;                <!-- logo-->

            padding: 100px 0;                <div id="head_left">

            margin-bottom: 30px;                    <a href="index.jsp"><img src="images/2.png"/></a>

        }                </div>

        .card-img-top {                <div id="head_top">

            height: 200px;                    <c:choose>

            object-fit: cover;	                	<c:when test="${user.user_name!=null}">

        }	                		<a href="UserExitServlet"><span>【退出】</span></a>

        .menu-card {	                		<span>欢迎您：<c:out value="${user.user_name}"></c:out></span>

            transition: transform 0.3s;	                	</c:when>

        }	                	<c:otherwise>

        .menu-card:hover {	                		<a href="register.jsp"><span>【注册】</span></a>

            transform: translateY(-5px);	                    	<a href="register.jsp"><span>【登录】</span></a>

            box-shadow: 0 5px 15px rgba(0,0,0,0.1);	                	</c:otherwise>

        }                	</c:choose>

    </style>                </div>

</head>                <!-- nav-->

<body>                <div id="head_right">

    <jsp:useBean id="user" scope="session" class="vo.Person"></jsp:useBean>                    <ul>

    <jsp:useBean id="menuBean" scope="page" class="vo.Menu"></jsp:useBean>                        <li><a href="index.jsp">首页</a></li>

    <jsp:useBean id="introduceBean" scope="page" class="vo.Introduce"></jsp:useBean>	                    <li><a href="shopping.jsp">我的购物车</a></li>

	                    <li><a href="MemberServlet">会员管理中心</a></li>

    <!-- Navigation -->	                    <li><a href="order_search.jsp">订单查询</a></li>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">	                    <li><a href="about.jsp">关于我们</a></li>

        <div class="container">                    </ul>

            <a class="navbar-brand" href="index.jsp">                </div>

                <i class="fas fa-utensils me-2"></i>WSDC 订餐系统            </div>

            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">            <div id="body">

                <span class="navbar-toggler-icon"></span>                <div id="body_left">

            </button>                    <!-- search-->

            <div class="collapse navbar-collapse" id="navbarNav">                    <div id="search">

                <ul class="navbar-nav me-auto">                        <input type="text" id="research"/>

                    <li class="nav-item"><a class="nav-link active" href="index.jsp">首页</a></li>                        <img src="images/search.png" width="30px"/>

                    <li class="nav-item"><a class="nav-link" href="shopping.jsp">购物车</a></li>                    </div>

                    <li class="nav-item"><a class="nav-link" href="order_search.jsp">我的订单</a></li>                    <!-- introduce-->

                    <li class="nav-item"><a class="nav-link" href="about.jsp">关于我们</a></li>                    <div id="introduce">

                </ul>                        <h2>商家介绍:</h2>

                <div class="d-flex align-items-center text-white">                        <p>

                    <c:choose>							<jsp:getProperty property="showIntroduce" name="introduceBean"/>

                        <c:when test="${user.user_name!=null}">                        </p>

                            <div class="dropdown">                    </div>

                                <button class="btn btn-outline-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">                </div>

                                    <i class="fas fa-user me-1"></i>${user.user_name}                <div id="body_right">

                                </button>                    <!-- 菜品-->

                                <ul class="dropdown-menu dropdown-menu-end">                    <div id="main">

                                    <li><a class="dropdown-item" href="MemberServlet">个人中心</a></li>                        <!-- 每日推荐-->

                                    <li><hr class="dropdown-divider"></li>                        <div class="food">

                                    <li><a class="dropdown-item" href="UserExitServlet">退出登录</a></li>                            <h2>每日推荐</h2>

                                </ul>                            <ul class="text">

                            </div>                            	<jsp:getProperty property="showMenuTop" name="menuBean"/>

                        </c:when>                            </ul>

                        <c:otherwise>                        </div>

                            <a href="register.jsp" class="btn btn-outline-light me-2">注册</a>                        <!-- 全部菜品-->

                            <a href="register.jsp" class="btn btn-primary">登录</a>                        <div class="food">

                        </c:otherwise>                            <h2 id="title">全部菜品</h2>

                    </c:choose>                            <ul class="text">

                </div>                            	<jsp:getProperty property="showMenuList" name="menuBean"/>

            </div>                            </ul>

        </div>                        </div>

    </nav>                    </div>

                </div>

    <!-- Hero Section -->            </div>

    <div class="hero-section text-center">            <!-- foot-->

        <div class="container">            <div id="footer">

            <h1 class="display-4 fw-bold">美味触手可及</h1>                <span>© 2016 ❤ _._桃子小姐mm</span>

            <p class="lead mb-4">精选食材，用心烹饪，为您带来极致的味蕾享受</p>            </div>

            <a href="#menu-section" class="btn btn-primary btn-lg px-5">立即点餐</a>        </div>

        </div>    </body>

    </div></html>

    <div class="container" id="menu-section">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-search me-2"></i>搜索美食</h5>
                    </div>
                    <div class="card-body">
                        <form action="index.jsp" method="post" class="input-group">
                            <input type="text" name="key" class="form-control" placeholder="输入菜品名称...">
                            <button class="btn btn-primary" type="submit">搜索</button>
                        </form>
                    </div>
                </div>

                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-bullhorn me-2"></i>餐厅公告</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach items="${introduceBean.allIntroduce}" var="intro">
                            <div class="alert alert-light border-start border-4 border-success">
                                <p class="mb-0">${intro.content}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <h2 class="mb-4 border-bottom pb-2">
                    <i class="fas fa-fire text-danger me-2"></i>热门推荐
                </h2>
                
                <div class="row g-4">
                    <c:forEach items="${menuBean.allMenu}" var="menu">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 menu-card shadow-sm">
                                <img src="images/${menu.menu_image}" class="card-img-top" alt="${menu.menu_name}" 
                                     onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title fw-bold">${menu.menu_name}</h5>
                                    <p class="card-text text-muted small flex-grow-1">${menu.menu_content}</p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5 text-danger mb-0">¥${menu.menu_price}</span>
                                        <a href="AddBuyServlet?id=${menu.menu_id}" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-cart-plus me-1"></i>加入购物车
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Pagination -->
                <nav class="mt-5">
                    <ul class="pagination justify-content-center">
                        <c:if test="${menuBean.currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="index.jsp?page=${menuBean.currentPage - 1}">上一页</a>
                            </li>
                        </c:if>
                        <li class="page-item disabled">
                            <span class="page-link">第 ${menuBean.currentPage} 页 / 共 ${menuBean.totalPages} 页</span>
                        </li>
                        <c:if test="${menuBean.currentPage < menuBean.totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="index.jsp?page=${menuBean.currentPage + 1}">下一页</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white mt-5 py-4">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 网上订餐系统. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
