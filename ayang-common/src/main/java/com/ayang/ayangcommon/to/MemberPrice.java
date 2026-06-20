package com.ayang.ayangcommon.to;


import lombok.Data;

import java.math.BigDecimal;

/**
 * ClassName: MemberPrice
 * Package: com.ayang.ayangcommon.to
 * Description:
 *
 * @Author ayang
 * @Create 2026/6/18 22:30
 * @Version 1.0
 */
@Data
public class MemberPrice {
    private Long id;
    private String name;
    private BigDecimal price;
}
