package com.weaverloft.ganttchart.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
@ComponentScan(basePackages = {"com.weaverloft.ganttchart"})
public class RootConfig {
    @Bean
    public DataSource dataSource(){
        HikariConfig hikariConfig=new HikariConfig();
        hikariConfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
        hikariConfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:XE");
        hikariConfig.setUsername("c##gantt");
        hikariConfig.setPassword("1234");

        HikariDataSource dataSource=new HikariDataSource(hikariConfig);
        return dataSource;
    }
}
