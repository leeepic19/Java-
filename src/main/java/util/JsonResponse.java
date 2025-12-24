package util;

import com.google.gson.Gson;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * JSON响应工具类
 */
public class JsonResponse {
    
    private static final Gson gson = new Gson();
    
    /**
     * 返回成功响应
     */
    public static void success(HttpServletResponse response, Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", data);
        result.put("message", "操作成功");
        writeJson(response, result);
    }
    
    /**
     * 返回成功响应（带消息）
     */
    public static void success(HttpServletResponse response, String message, Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", data);
        result.put("message", message);
        writeJson(response, result);
    }
    
    /**
     * 返回失败响应
     */
    public static void error(HttpServletResponse response, String message) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", message);
        writeJson(response, result);
    }
    
    /**
     * 写入JSON响应
     */
    private static void writeJson(HttpServletResponse response, Object data) {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(data));
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
