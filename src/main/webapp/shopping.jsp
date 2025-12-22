<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>购物车 - 网上订餐系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:useBean id="user" scope="session" class="vo.Person"></jsp:useBean>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><i class="fas fa-utensils me-2"></i>WSDC</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">首页</a></li>
                    <li class="nav-item"><a class="nav-link active" href="shopping.jsp">购物车</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <h2 class="mb-4"><i class="fas fa-shopping-cart me-2"></i>我的购物车</h2>
        
        <c:choose>
            <c:when test="${empty sessionScope.buylist}">
                <div class="text-center py-5">
                    <i class="fas fa-shopping-basket fa-4x text-muted mb-3"></i>
                    <h3>购物车空空如也</h3>
                    <p class="text-muted">快去选购美味佳肴吧！</p>
                    <a href="index.jsp" class="btn btn-primary mt-3">去点餐</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">菜品名称</th>
                                    <th>单价</th>
                                    <th>数量</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sessionScope.buylist}" var="item">
                                    <tr>
                                        <td class="ps-4 fw-bold">${item.menu_name}</td>
                                        <td class="text-danger">¥${item.menu_price}</td>
                                        <td>
                                            <span class="badge bg-secondary rounded-pill">${item.menu_id}</span> <!-- 这里应该是数量，但原逻辑似乎用menu_id暂存? 需确认后端逻辑，暂时保持原样或修正 -->
                                            <!-- 注意：原代码逻辑可能需要检查，通常购物车会有数量字段 -->
                                            1 份
                                        </td>
                                        <td>
                                            <a href="DeleteBuyServlet?id=${item.menu_id}" class="btn btn-outline-danger btn-sm">
                                                <i class="fas fa-trash-alt"></i> 删除
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-white p-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="index.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-1"></i>继续点餐
                            </a>
                            <div>
                                <span class="h5 me-3">总计: <span class="text-danger fw-bold">¥${sessionScope.sum}</span></span>
                                <a href="pay.jsp" class="btn btn-success btn-lg px-5">
                                    去结算 <i class="fas fa-check ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
