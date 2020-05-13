package com.eugene.sumarry.mall.user.dao;

import com.eugene.sumarry.mall.common.dao.BaseDao;
import com.eugene.sumarry.mall.user.model.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao extends BaseDao<User, Long> {


    User getByPhone(@Param("phone") String phone);
}
