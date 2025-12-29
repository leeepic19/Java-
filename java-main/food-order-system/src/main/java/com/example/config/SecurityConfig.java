package com.example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

/**
 * 安全配置类
 * 用于缓解CVE漏洞风险，特别是路径遍历攻击
 */
@Configuration
public class SecurityConfig implements WebMvcConfigurer {

    /**
     * 注册路径遍历防护过滤器
     * 用于缓解CVE-2025-41242等路径遍历漏洞
     */
    @Bean
    public FilterRegistrationBean<PathTraversalProtectionFilter> pathTraversalProtectionFilter() {
        FilterRegistrationBean<PathTraversalProtectionFilter> registration = new FilterRegistrationBean<>();
        registration.setFilter(new PathTraversalProtectionFilter());
        registration.addUrlPatterns("/*");
        registration.setName("pathTraversalProtectionFilter");
        registration.setOrder(1);
        return registration;
    }

    /**
     * 路径遍历防护过滤器
     * 检测并阻止可疑的路径遍历尝试
     */
    public static class PathTraversalProtectionFilter implements Filter {

        private static final String[] SUSPICIOUS_PATTERNS = {
            "../", "..\\", "%2e%2e%2f", "%2e%2e%5c", 
            "..%2f", "..%5c", "%252e%252e%252f", "%252e%252e%255c",
            "null/", "NULL/"
        };

        @Override
        public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
                throws IOException, ServletException {
            
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            
            String requestURI = httpRequest.getRequestURI().toLowerCase();
            String queryString = httpRequest.getQueryString();
            
            // 检查请求URI中的可疑模式
            if (containsSuspiciousPattern(requestURI) || 
                (queryString != null && containsSuspiciousPattern(queryString.toLowerCase()))) {
                
                httpResponse.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                httpResponse.getWriter().write("Bad Request: Suspicious path detected");
                return;
            }
            
            chain.doFilter(request, response);
        }
        
        private boolean containsSuspiciousPattern(String input) {
            return Arrays.stream(SUSPICIOUS_PATTERNS)
                    .anyMatch(input::contains);
        }
    }
}