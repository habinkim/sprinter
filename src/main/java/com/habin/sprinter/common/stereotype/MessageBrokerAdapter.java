package com.habin.sprinter.common.stereotype;


import org.springframework.core.annotation.AliasFor;
import org.springframework.stereotype.Component;

import java.lang.annotation.*;

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface MessageBrokerAdapter {

    @AliasFor(annotation = Component.class)
    String value() default "";

}
