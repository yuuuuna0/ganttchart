package com.weaverloft.ganttchart.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan("com.weaverloft.ganttchart.controller")
public class ServletConfig implements WebMvcConfigurer {
    /*
    //정적 리소스 위치 등록
    라이브러리의 클래스를 빈으로 써야한다. --> 소스를 편집할 수 없으므로 @Component 설정 불가
    <beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <beans:property name="prefix" value="/WEB-INF/views/" />
        <beans:property name="suffix" value=".jsp" />
    </beans:bean>
    public void addResuourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/res/**")  //화면에서 요청하는 리소스 위치
                .addResourceLocations("/resources/")        //실제로 그 리소스들이 있는 물리적 경로
                .setCachePeriod(60*60*24*365);              //cache로 남겨둘 기간 설정
    }
    */
    @Bean
    public InternalResourceViewResolver viewResolver(){
        InternalResourceViewResolver resolver=new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }
}
