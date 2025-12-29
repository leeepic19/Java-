// FoodVO类代码（放在com.example.entity包下）
package com.example.entity;

import java.math.BigDecimal;
import java.util.Date;

public class FoodVO {
    private Long id;
    private Long merchantId;
    private String merchantName;
    private String foodName;
    private BigDecimal price;
    private Integer stock;
    private String foodImg;
    private Date createTime;

    // Getter和Setter方法
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getMerchantId() { return merchantId; }
    public void setMerchantId(Long merchantId) { this.merchantId = merchantId; }
    public String getMerchantName() { return merchantName; }
    public void setMerchantName(String merchantName) { this.merchantName = merchantName; }
    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
    public String getFoodImg() { return foodImg; }
    public void setFoodImg(String foodImg) { this.foodImg = foodImg; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}