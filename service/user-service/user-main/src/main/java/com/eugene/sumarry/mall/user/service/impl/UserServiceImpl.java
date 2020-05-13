package com.eugene.sumarry.mall.user.service.impl;

import com.eugene.sumarry.jwtutil.entry.JwtSign;
import com.eugene.sumarry.mall.common.Enum.HTTPErrorCode;
import com.eugene.sumarry.mall.common.util.Assert;
import com.eugene.sumarry.mall.user.dao.UserDao;
import com.eugene.sumarry.mall.user.model.User;
import com.eugene.sumarry.mall.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private JwtSign jwtSign;

    @Autowired
    private UserDao userDao;

    @Override
    public String login(String phone, String password) {
        Assert.notNull(phone, HTTPErrorCode.LOGIN_NULL_ARGUMENT);
        Assert.notNull(password, HTTPErrorCode.LOGIN_NULL_ARGUMENT);
        User user = userDao.getByPhone(phone);
        Assert.notNull(user, HTTPErrorCode.LOGIN_ILLEGAL_ARGUMENT);

        if (password.equals(user.getPassword())) {
            // 先模拟每次生成新的
            return jwtSign.sign(phone, user);
        }

        Assert.end(HTTPErrorCode.LOGIN_ILLEGAL_ARGUMENT);

        return null;
    }

    @Override
    public List<User> find() {
        return userDao.getAll();
    }
}
