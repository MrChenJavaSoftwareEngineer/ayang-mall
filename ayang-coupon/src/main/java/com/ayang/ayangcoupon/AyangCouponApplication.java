package com.ayang.ayangcoupon;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class AyangCouponApplication {

    public static void main(String[] args) {
        SpringApplication.run(AyangCouponApplication.class, args);
    }

}
