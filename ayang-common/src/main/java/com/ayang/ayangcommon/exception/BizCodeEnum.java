package com.ayang.ayangcommon.exception;


/**
 * ClassName: BizCodeEnume
 * Package: com.ayang.ayangcommon.exception
 * Description:
 *
 * @Author ayang
 * @Create 2026/6/18 22:29
 * @Version 1.0
 */
public enum BizCodeEnum {
    UNKNOW_EXCEPTION(10000,"系统未知异常"),
    VAILD_EXCEPTION(10001,"参数格式校验失败");

    private int code;
    private String msg;
    BizCodeEnum(int code,String msg){
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
