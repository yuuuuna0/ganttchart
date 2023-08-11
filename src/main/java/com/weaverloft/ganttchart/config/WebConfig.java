package com.weaverloft.ganttchart.config;

import com.weaverloft.ganttchart.controller.Interceptor.LoginCheckInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    private LoginCheckInterceptor loginCheckInterceptor;

    public WebConfig(LoginCheckInterceptor loginCheckInterceptor) {
        this.loginCheckInterceptor = loginCheckInterceptor;
    }

    //인터셉터 등록
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginCheckInterceptor);
    }
}
