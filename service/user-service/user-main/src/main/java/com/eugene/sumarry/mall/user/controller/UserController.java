package com.eugene.sumarry.mall.user.controller;

import com.eugene.sumarry.mall.common.controller.BaseController;
import com.eugene.sumarry.mall.common.web.Message;
import com.eugene.sumarry.mall.common.web.RPCTemplate;
import com.eugene.sumarry.mall.goods.GoodsClient;
import com.eugene.sumarry.mall.order.OrderClient;
import com.eugene.sumarry.mall.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@RestController
@RequestMapping("/v1/users")
public class UserController extends BaseController {

    @Autowired
    private GoodsClient goodsClient;

    @Autowired
    private OrderClient orderClient;

    @Autowired
    private UserService userService;

    @GetMapping
    public Message index() {
        Object goodsResult = RPCTemplate.exec(() -> goodsClient.index());

        Object orderResult = RPCTemplate.exec(() -> orderClient.index());

        Map<String, Object> map = new HashMap<>();
        map.put("goodsResult", goodsResult);
        map.put("orderResult", orderResult);

        return Message.ok(map);
    }


    @PostMapping("/login")
    public Message login(@RequestBody Map<String, Object> map) {
        String userName = (String) map.get("phone");
        String password = (String) map.get("password");
        return Message.ok(userService.login(userName, password));
    }
}
