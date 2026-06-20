package com.ayang.ayangcommon.to;


import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * ClassName: SkuReductionTo
 * Package: com.ayang.ayangcommon.to
 * Description:
 *
 * @Author ayang
 * @Create 2026/6/18 22:47
 * @Version 1.0
 */
@Data
public class SkuReductionTo {
    private Long skuId;
    private int fullCount;
    private BigDecimal discount;
    private int countStatus;
    private BigDecimal fullPrice;
    private BigDecimal reducePrice;
    private int priceStatus;
    private List<MemberPrice> memberPrice;
}
