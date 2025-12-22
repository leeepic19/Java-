<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单结算 - 网上订餐系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:useBean id="user" scope="session" class="vo.Person"></jsp:useBean>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>订单结算</h4>
                    </div>
                    <div class="card-body p-4">
                        <c:choose>
                            <c:when test="${user.user_name == null}">
                                <div class="alert alert-warning text-center">
                                    <i class="fas fa-exclamation-triangle me-2"></i>您尚未登录，请先登录后再提交订单。
                                    <div class="mt-3">
                                        <a href="register.jsp" class="btn btn-primary">去登录</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form action="OrdersPayServlet" method="post">
                                    <h5 class="mb-3 border-bottom pb-2">配送信息</h5>
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">收货人</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" value="${user.user_realname}" readonly>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">联系电话</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" placeholder="请输入联系电话" required>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-3 col-form-label">收货地址</label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" rows="2" placeholder="请输入详细收货地址" required></textarea>
                                        </div>
                                    </div>

                                    <h5 class="mb-3 border-bottom pb-2 mt-4">订单备注</h5>
                                    <div class="mb-3">
                                        <label class="form-label">口味偏好</label>
                                        <select name="order_notice" class="form-select">
                                            <option value="正常">正常</option>
                                            <option value="微辣">微辣</option>
                                            <option value="中辣">中辣</option>
                                            <option value="特辣">特辣</option>
                                            <option value="不吃葱蒜">不吃葱蒜</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">其他要求</label>
                                        <textarea name="other_notice" class="form-control" rows="2" placeholder="如有其他特殊要求请在此填写"></textarea>
                                    </div>

                                    <div class="alert alert-info mt-4">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span><strong>支付金额：</strong></span>
                                            <span class="h3 text-danger mb-0">¥${sessionScope.sum}</span>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2 mt-4">
                                        <button type="submit" class="btn btn-success btn-lg">
                                            <i class="fab fa-weixin me-2"></i>确认支付
                                        </button>
                                        <a href="shopping.jsp" class="btn btn-outline-secondary">返回购物车</a>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
