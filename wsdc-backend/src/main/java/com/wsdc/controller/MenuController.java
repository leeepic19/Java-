package com.wsdc.controller;

import com.wsdc.common.Result;
import com.wsdc.dto.MenuResponse;
import com.wsdc.service.MenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "Menu Management")
@RestController
@RequestMapping("/api/menu")
@RequiredArgsConstructor
@CrossOrigin
public class MenuController {
    
    private final MenuService menuService;

    @ApiOperation("Get Menu List")
    @GetMapping("/list")
    public Result<List<MenuResponse>> getList(
            @RequestParam(required = false) String keyword) {
        try {
            List<MenuResponse> menus = menuService.getList(keyword);
            return Result.success(menus);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @ApiOperation("Get Menu Detail")
    @GetMapping("/{id}")
    public Result<MenuResponse> getById(@PathVariable Long id) {
        try {
            MenuResponse menu = menuService.getById(id);
            return Result.success(menu);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
