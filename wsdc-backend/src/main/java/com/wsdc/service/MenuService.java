package com.wsdc.service;

import com.wsdc.dto.MenuResponse;
import com.wsdc.entity.Menu;
import com.wsdc.repository.MenuRepository;
import com.wsdc.util.StringUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MenuService {
    
    private final MenuRepository menuRepository;

    public List<MenuResponse> getList(String keyword) {
        List<Menu> menus;
        
        if (StringUtil.isNotEmpty(keyword)) {
            menus = menuRepository.findByMenuNameContaining(keyword);
        } else {
            menus = menuRepository.findAll();
        }

        return menus.stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    public MenuResponse getById(Long id) {
        Menu menu = menuRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Menu item not found"));
        return convertToResponse(menu);
    }

    private MenuResponse convertToResponse(Menu menu) {
        MenuResponse response = new MenuResponse();
        BeanUtils.copyProperties(menu, response);
        return response;
    }
}
