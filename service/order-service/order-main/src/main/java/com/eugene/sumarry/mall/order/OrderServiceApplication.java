package com.eugene.sumarry.mall.order;

import com.eugene.sumarry.jwtutil.anno.EnableJwtSign;
import com.eugene.sumarry.mall.common.anno.StartApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@StartApplication
@EnableEurekaClient
@EnableJwtSign
public class OrderServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrderServiceApplication.class);
    }
}
