# 项目概况

## 一、目标

- [ ] jwt完成服务间认证
- [ ] elasticsearch + logstash完成商品列表搜索功能
- [ ] 查看商品详情功能  => 考虑缓存穿透
- [ ] 首页热卖商品 => 考虑缓存击穿
- [ ] 首页商品数据渲染 => 考虑缓存雪崩
- [ ] 使用消息队列集成下单 => 考虑分布式锁 + 分布式事务  + 消息队列幂等性
- [ ] 商品点赞 => 利用redis原子性 + 消息队列
- [ ] 今日热卖商品 => redis zset集合实现
- [ ] jenkins + docker自动化部署

## 二、spring cloud微服务架构

* 各项目占用端口汇总

  |    服务名     | 暴露端口 |
  | :-----------: | :------: |
  | config-server |  10000   |
  | eureka-server |   8000   |
  |  zuul-server  |   9000   |
  | user-service  |   5000   |
  | goods-service |   6000   |
  | order-service |   7000   |

* 项目启动顺序:

  ```java
  1. config-server
  2. eureka-server
  3. zuul-server
  其他的任意
  ```



## 特点

* 扩展了`@SpringBootApplication`注解，修改了它默认的扫描包路径

  ```java
  /**
   * 因为每个模块的包名不一致，而@ComponentScan
   * 不支持继承(无@Inherited注解),
   * 而@SpringBootApplication有@Inherited注解
   * 就相当于把@SpringBootApplication注解的功能
   * 给扩展了。
   *
   * 为什么要扩展它呢？
   * 因为maven多模块下，有可能每个模块的项目路口类
   * 所处的路径不一致，导致不能扫描到其他模块的spring
   * 相关的注解
   */
  @Retention(RetentionPolicy.RUNTIME)
  @Target(ElementType.TYPE)
  @SpringBootApplication
  @ComponentScan("com.eugene.sumarry.mall")
  public @interface StartApplication {
  }
  
  ```

  

