package com.ayang.ayangadmin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient
@SpringBootApplication
public class AyangAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(AyangAdminApplication.class, args);
    }

}
