package com.mk.fitter.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
	@Bean
	public Docket api() {
		return new Docket(DocumentationType.SWAGGER_2)
			.select()
			.apis(RequestHandlerSelectors.basePackage("com.mk.fitter.api")) // 컨트롤러 패키지 지정
			.paths(PathSelectors.any())
			.build()
			.apiInfo(apiInfo())
			.enable(true);
	}

	private ApiInfo apiInfo() {
		return new ApiInfoBuilder()
			.title("Fitter API")
			.description("Fitter 어플리케이션에 사용되는 REST API 페이지 입니다.")
			.version("1.0")
			.build();
	}
}
