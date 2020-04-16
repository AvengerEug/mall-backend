package com.eugene.sumarry.mall.common.util;

import com.eugene.sumarry.mall.common.Enum.HTTPErrorCode;
import com.eugene.sumarry.mall.common.exception.BusinessException;
import org.springframework.util.ObjectUtils;

public final class Assert {

    public static void notNull(String value, HTTPErrorCode httpErrorCode) {
        if (ObjectUtils.isEmpty(value)) {
            throw new BusinessException(
                    httpErrorCode.getCode(), httpErrorCode.getMessage()
            );
        }
    }

    public static void end(HTTPErrorCode httpErrorCode) {
        throw new BusinessException(
                httpErrorCode.getCode(), httpErrorCode.getMessage()
        );
    }

}
