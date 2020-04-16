package com.eugene.sumarry.mall.common.web;

public class Message {

    public final static Integer OK = 200;
    public final static Integer ERROR = 500;
    public final static Integer BAD_REQUEST = 400;
    private String errorMessage;
    private Object data;
    private Integer statusCode;

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }


    private static class SuccessMessage extends Message {


        public SuccessMessage() {
            super.statusCode = OK;
        }

        public SuccessMessage(Object data) {
            super.statusCode = OK;
            super.data = data;
        }

        public Object getData() {
            return super.data;
        }

        public void setData(Object data) {
            super.data = data;
        }
    }

    private static class ErrorMessage extends  Message {

        public ErrorMessage(String errorMessage) {
            super.statusCode = ERROR;
            super.errorMessage = errorMessage;
        }

        public String getErrorMessage() {
            return super.errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            super.errorMessage = errorMessage;
        }
    }

    public static Message ok() {
        return new SuccessMessage();
    }

    public static Message ok(Object data) {
        return new SuccessMessage(data);
    }

    public static Message error(String message) {
        return new ErrorMessage(message);
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
