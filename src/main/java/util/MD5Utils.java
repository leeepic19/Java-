package util;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * MD5 加密工具类
 */
public class MD5Utils {
    
    // 盐值
    private static final String SALT = "wsdc@2024#secure";
    
    /**
     * MD5加密（带盐值）
     * @param password 明文密码
     * @return 加密后的密码
     */
    public static String encrypt(String password) {
        if (password == null || password.trim().isEmpty()) {
            return null;
        }
        // 密码+盐值进行MD5加密
        return DigestUtils.md5Hex(password + SALT);
    }
    
    /**
     * 验证密码
     * @param inputPassword 用户输入的密码
     * @param encryptedPassword 数据库中的加密密码
     * @return true 密码正确，false 密码错误
     */
    public static boolean verify(String inputPassword, String encryptedPassword) {
        if (inputPassword == null || encryptedPassword == null) {
            return false;
        }
        return encrypt(inputPassword).equals(encryptedPassword);
    }
    
    /**
     * 简单MD5加密（不带盐值）
     * @param text 明文
     * @return MD5加密结果
     */
    public static String md5(String text) {
        return DigestUtils.md5Hex(text);
    }
}
