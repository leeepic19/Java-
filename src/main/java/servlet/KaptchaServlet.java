package servlet;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Properties;

/**
 * 验证码生成Servlet
 */
@WebServlet("/kaptcha")
public class KaptchaServlet extends HttpServlet {
    
    private DefaultKaptcha kaptcha;
    
    @Override
    public void init() throws ServletException {
        kaptcha = new DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty("kaptcha.image.width", "120");
        properties.setProperty("kaptcha.image.height", "40");
        properties.setProperty("kaptcha.textproducer.char.length", "4");
        properties.setProperty("kaptcha.textproducer.char.string", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
        properties.setProperty("kaptcha.textproducer.font.size", "32");
        properties.setProperty("kaptcha.textproducer.font.color", "blue");
        properties.setProperty("kaptcha.background.clear.from", "lightGray");
        properties.setProperty("kaptcha.background.clear.to", "white");
        Config config = new Config(properties);
        kaptcha.setConfig(config);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 生成验证码文本
        String text = kaptcha.createText();
        // 将验证码文本存入session
        request.getSession().setAttribute("kaptcha", text);
        
        // 生成验证码图片
        BufferedImage image = kaptcha.createImage(text);
        
        // 设置响应头
        response.setContentType("image/jpeg");
        response.setHeader("Cache-Control", "no-store, no-cache");
        
        // 输出图片
        ImageIO.write(image, "jpg", response.getOutputStream());
    }
}
