package com.eugene.sumarry.mall.user;

import com.eugene.sumarry.jwtutil.anno.EnableJwtSign;
import com.eugene.sumarry.mall.common.anno.StartApplication;
import com.eugene.sumarry.mall.goods.GoodsClient;
import com.eugene.sumarry.mall.order.OrderClient;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableEurekaClient
@EnableFeignClients(
        clients = {
                GoodsClient.class,
                OrderClient.class
        }
)
@EnableJwtSign
@StartApplication
public class UserServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(UserServiceApplication.class);
    }
}
