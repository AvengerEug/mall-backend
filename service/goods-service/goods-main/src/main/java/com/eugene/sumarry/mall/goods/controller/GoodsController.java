package com.eugene.sumarry.mall.goods.controller;

import com.eugene.sumarry.mall.common.controller.BaseController;
import com.eugene.sumarry.mall.common.web.Message;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/goods")
public class GoodsController extends BaseController {


    @GetMapping
    public Message index() {
        return Message.ok(new int[]{1, 2, 3, 4, 5});
    }
}
