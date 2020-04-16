package com.eugene.sumarry.mall.order;


import com.eugene.sumarry.mall.common.web.CommonClientInterceptor;
import com.eugene.sumarry.mall.common.web.Message;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@FeignClient(value = "ORDER-SERVICE", configuration = CommonClientInterceptor.class)
@RequestMapping("/v1/orders")
public interface OrderClient {

    @GetMapping
    Message index();
}
