package com.eugene.sumarry.mall.common.web;

import com.eugene.sumarry.mall.common.filter.ContextFilter;
import com.eugene.sumarry.mall.common.filter.JWTAuthFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MVCConfig {


    @Bean
    public FilterRegistrationBean contextFilter() {
        FilterRegistrationBean bean = new FilterRegistrationBean(new ContextFilter());
        bean.setOrder(10);
        return bean;
    }


    @Bean
    public FilterRegistrationBean jwtAuthFilter() {
        FilterRegistrationBean bean = new FilterRegistrationBean(new JWTAuthFilter());
        bean.setOrder(20);
        return bean;
    }

}
