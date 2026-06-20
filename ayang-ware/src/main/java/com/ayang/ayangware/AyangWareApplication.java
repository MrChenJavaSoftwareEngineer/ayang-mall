package com.ayang.ayangware;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class AyangWareApplication {

    public static void main(String[] args) {
        SpringApplication.run(AyangWareApplication.class, args);
    }

}
