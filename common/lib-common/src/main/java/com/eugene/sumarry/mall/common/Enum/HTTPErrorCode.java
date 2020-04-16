package com.eugene.sumarry.mall.common.Enum;

public enum HTTPErrorCode {

    /**
     * User模块:       代号100
     * controller层        代码100
     * (service层          代号200     dao层   代号: 300  以此类推
     * dao层               代号300
     * util层              代号400
     * 业务代码:       代码0001  依次递增
     */
    LOGIN_NULL_ARGUMENT("1002000001", "用户名或密码为空"),
    LOGIN_ILLEGAL_ARGUMENT("1002000002", "用户名或密码错误")
    ;

    private String code;
    private String message;

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    HTTPErrorCode(String code, String message) {
        this.code = code;
        this.message = message;
    }


}
