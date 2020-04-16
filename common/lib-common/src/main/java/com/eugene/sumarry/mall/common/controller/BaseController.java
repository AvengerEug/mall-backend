package com.eugene.sumarry.mall.common.controller;

import com.eugene.sumarry.mall.common.exception.BusinessException;
import com.eugene.sumarry.mall.common.web.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

public class BaseController {

    private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

    private static final String DEFAULT_ERROR_MESSAGE = "系统异常";

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Message exceptionHandler(Exception e) {
        String errorMessage = DEFAULT_ERROR_MESSAGE;
        if (e instanceof BusinessException && e.getMessage() != null) {
            errorMessage = e.getMessage();
        } else if (e instanceof HttpMessageNotReadableException) {
            // post方法中无请求体参数
            errorMessage = "参数传递错误";
        }

        logger.error(errorMessage, e);
        return Message.error(errorMessage);
    }
}
