package com.habin.sprinter;

import org.springframework.boot.SpringApplication;

public class TestSprinterApplication {

    public static void main(String[] args) {
        SpringApplication.from(SprinterApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
