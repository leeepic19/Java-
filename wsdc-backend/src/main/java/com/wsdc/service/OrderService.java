package com.wsdc.service;

import com.wsdc.dto.OrderRequest;
import com.wsdc.dto.OrderResponse;
import com.wsdc.entity.Menu;
import com.wsdc.entity.Order;
import com.wsdc.entity.User;
import com.wsdc.repository.MenuRepository;
import com.wsdc.repository.OrderRepository;
import com.wsdc.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {
    
    private final OrderRepository orderRepository;
    private final MenuRepository menuRepository;
    private final UserRepository userRepository;

    @Transactional
    public OrderResponse createOrder(String username, OrderRequest request) {
        User user = userRepository.findByUserName(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Menu menu = menuRepository.findById(request.getMenuId())
                .orElseThrow(() -> new RuntimeException("Menu item not found"));

        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setMenuId(request.getMenuId());
        order.setOrderNum(request.getOrderNum());
        order.setOrderNotice(request.getOrderNotice());
        order.setOtherNotice(request.getOtherNotice());
        order.setStates("未付款");

        order = orderRepository.save(order);
        return convertToResponse(order, menu);
    }

    @Transactional
    public OrderResponse payOrder(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        
        if (!"未付款".equals(order.getStates())) {
            throw new RuntimeException("Order cannot be paid");
        }

        order.setStates("已付款");
        orderRepository.save(order);

        Menu menu = menuRepository.findById(order.getMenuId()).orElse(null);
        return convertToResponse(order, menu);
    }

    public List<OrderResponse> getMyOrders(String username) {
        User user = userRepository.findByUserName(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        List<Order> orders = orderRepository.findByUserIdOrderByOrderIdDesc(user.getUserId());
        
        return orders.stream()
                .map(order -> {
                    Menu menu = menuRepository.findById(order.getMenuId()).orElse(null);
                    return convertToResponse(order, menu);
                })
                .collect(Collectors.toList());
    }

    private OrderResponse convertToResponse(Order order, Menu menu) {
        OrderResponse response = new OrderResponse();
        response.setOrderId(order.getOrderId());
        response.setUserId(order.getUserId());
        response.setMenuId(order.getMenuId());
        response.setMenuName(menu != null ? menu.getMenuName() : "");
        response.setOrderNum(order.getOrderNum());
        response.setOrderNotice(order.getOrderNotice());
        response.setOtherNotice(order.getOtherNotice());
        response.setStates(order.getStates());
        return response;
    }
}
