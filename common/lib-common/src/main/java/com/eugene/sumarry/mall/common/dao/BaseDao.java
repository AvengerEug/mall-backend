package com.eugene.sumarry.mall.common.dao;

import java.util.List;

public interface BaseDao<T, K> {

    void insert(T entity);

    void update(T entity);

    List<T> getAll();

    T getById(K id);

    void delete(K id);

    void batchInsert(List<T> list);

    void batchDelete(List<K> list);
}
