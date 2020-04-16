package com.eugene.sumarry.mall.goods;

import com.eugene.sumarry.mall.common.web.CommonClientInterceptor;
import com.eugene.sumarry.mall.common.web.Message;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient(value = "GOODS-SERVICE", configuration = CommonClientInterceptor.class)
@RequestMapping("/v1/goods")
public interface GoodsClient {

    @GetMapping
    Message index();
}
