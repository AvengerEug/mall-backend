package com.eugene.sumarry.mall.user.service;

import com.eugene.sumarry.jwtutil.entry.JwtSign;
import com.eugene.sumarry.mall.common.Enum.HTTPErrorCode;
import com.eugene.sumarry.mall.common.util.Assert;
import com.eugene.sumarry.mall.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private JwtSign jwtSign;

    @Override
    public String login(String userName, String password) {
        Assert.notNull(userName, HTTPErrorCode.LOGIN_NULL_ARGUMENT);
        Assert.notNull(password, HTTPErrorCode.LOGIN_NULL_ARGUMENT);
        if (userName.equals("eugene") && password.equals("eugene")) {
            User user = new User();
            user.setUserId(100L);
            user.setPassword("eugene");
            user.setUserName("eugene");
            // 先模拟每次生成新的
            String newJwtToken = jwtSign.sign(userName, user);
            return newJwtToken;
        }

        Assert.end(HTTPErrorCode.LOGIN_ILLEGAL_ARGUMENT);

        return null;
    }
}
