package vo;

/**
 * 购物车项实体类
 */
public class CartItem {
    private Menu menu;          // 菜品信息
    private int quantity;       // 数量
    private String notice;      // 口味要求
    private String otherNotice; // 其他要求
    
    public CartItem() {
    }
    
    public CartItem(Menu menu, int quantity) {
        this.menu = menu;
        this.quantity = quantity;
    }
    
    /**
     * 获取小计金额
     */
    public double getSubtotal() {
        return menu.getMenu_price() * quantity;
    }
    
    // Getters and Setters
    public Menu getMenu() {
        return menu;
    }
    
    public void setMenu(Menu menu) {
        this.menu = menu;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getNotice() {
        return notice;
    }
    
    public void setNotice(String notice) {
        this.notice = notice;
    }
    
    public String getOtherNotice() {
        return otherNotice;
    }
    
    public void setOtherNotice(String otherNotice) {
        this.otherNotice = otherNotice;
    }
}
