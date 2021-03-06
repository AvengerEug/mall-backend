package com.eugene.sumarry.mall.common.service;

import java.util.List;

public interface BaseService<T, K> {

    default T create(T t) {
        return null;
    }

    default T update(T t) {
        return null;
    }

    default T get(K k) {
        return null;
    }

    default List<T> find() {
        return null;
    }

    default void batchCreate(List<T> list) { }

    default List<T> batchUpdate(List<T> list) {
        return null;
    }
}
