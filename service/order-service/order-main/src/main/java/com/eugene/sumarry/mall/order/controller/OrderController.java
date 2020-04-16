package com.eugene.sumarry.mall.order.controller;

import com.eugene.sumarry.mall.common.controller.BaseController;
import com.eugene.sumarry.mall.common.web.Message;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/orders")
public class OrderController extends BaseController {


    @GetMapping
    public Message index() {
        return Message.ok(new int[]{11, 22, 33, 44, 55});
    }

}
