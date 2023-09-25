package com.weaverloft.ganttchart.exception;

import com.weaverloft.ganttchart.Service.ErrorLogService;
import com.weaverloft.ganttchart.dto.ErrorLog;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Aspect
public class LogAdvice {

    private  final Logger logger = LoggerFactory.getLogger(LogAdvice.class);
    private ErrorLogService errorLogService;

    public LogAdvice(ErrorLogService errorLogService) {
        this.errorLogService = errorLogService;
        //logger = LoggerFactory.getLogger(LogAdvice.class);
        System.out.println("logger = " + logger);
    }

    @AfterThrowing(pointcut="execution(* com.weaverloft.ganttchart.*.*.*(..))", throwing = "e")
    public void logAdvice(JoinPoint joinPoint, Exception e){
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        String errorLocation = methodSignature.toString();
        //에러 남기기 --> id 어떻게 남기지?
        String id ="";
        ErrorLog errorLog = new ErrorLog(0,e.getMessage(),new Date(),errorLocation);
        System.out.println("errorLog = " + errorLog);
        errorLogService.createLog(errorLog);
    }
}
