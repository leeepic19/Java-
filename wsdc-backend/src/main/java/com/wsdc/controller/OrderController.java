package com.wsdc.controller;

import com.wsdc.common.Result;
import com.wsdc.dto.OrderRequest;
import com.wsdc.dto.OrderResponse;
import com.wsdc.service.OrderService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(tags = "Order Management")
@RestController
@RequestMapping("/api/order")
@RequiredArgsConstructor
@CrossOrigin
public class OrderController {
    
    private final OrderService orderService;

    @ApiOperation("Create Order")
    @PostMapping("/create")
    public Result<OrderResponse> createOrder(@Valid @RequestBody OrderRequest request) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            OrderResponse order = orderService.createOrder(username, request);
            return Result.success(order);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @ApiOperation("Pay Order")
    @PostMapping("/pay/{orderId}")
    public Result<OrderResponse> payOrder(@PathVariable Long orderId) {
        try {
            OrderResponse order = orderService.payOrder(orderId);
            return Result.success(order);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @ApiOperation("Get My Orders")
    @GetMapping("/my")
    public Result<List<OrderResponse>> getMyOrders() {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            List<OrderResponse> orders = orderService.getMyOrders(username);
            return Result.success(orders);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
