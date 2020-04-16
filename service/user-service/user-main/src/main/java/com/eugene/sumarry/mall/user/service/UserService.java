package com.eugene.sumarry.mall.user.service;

import com.eugene.sumarry.mall.common.service.BaseService;
import com.eugene.sumarry.mall.user.model.User;

public interface UserService extends BaseService<User, Long> {

    String login(String userName, String password);

}
