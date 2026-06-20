package com.ayang.ayangcommon.to;


import lombok.Data;

import java.math.BigDecimal;

/**
 * ClassName: SpuBoundTo
 * Package: com.ayang.ayangcommon.to
 * Description:
 *
 * @Author ayang
 * @Create 2026/6/18 22:47
 * @Version 1.0
 */
@Data
public class SpuBoundTo {
    private Long spuId;
    private BigDecimal buyBounds;
    private BigDecimal growBounds;
}
