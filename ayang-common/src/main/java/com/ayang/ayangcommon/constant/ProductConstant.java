package com.ayang.ayangcommon.constant;


/**
 * ClassName: ProductConstant
 * Package: com.ayang.ayangcommon.constant
 * Description:
 *
 * @Author ayang
 * @Create 2026/6/18 22:16
 * @Version 1.0
 */
public class ProductConstant {
    public enum AtrrEnum {
        ATTR_TYPE_BASE(1,"基本属性"),
        ATTR_TYPE_SALE(0,"销售属性");
        private int code;
        private String msg;


        AtrrEnum(int code, String msg){
            this.code = code;
            this.msg = msg;
        }

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }
}
