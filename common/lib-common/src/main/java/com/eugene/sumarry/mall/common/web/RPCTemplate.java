package com.eugene.sumarry.mall.common.web;

import com.eugene.sumarry.mall.common.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.function.Supplier;

public final class RPCTemplate {

    private static final Logger logger = LoggerFactory.getLogger(RPCTemplate.class);

    public static <T> T exec(Supplier supplier) {
        Message message = (Message) supplier.get();
        if (message.getStatusCode().equals(Message.OK)) {
            return (T)message.getData();
        } else if (message.getStatusCode().equals(Message.ERROR)) {
            // 抛异常了
            logger.error("Feign client调用异常, 错误源: {}, 错误信息: {}", supplier, message.getErrorMessage());
            throw new BusinessException();
        }

        return null;
    }
}
