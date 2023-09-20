package com.mk.fitter.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.mk.fitter.api.common.filter.JwtAuthenticationProcessingFilter;
import com.mk.fitter.api.common.oauth.handler.OAuth2LoginFailureHandler;
import com.mk.fitter.api.common.oauth.handler.OAuth2LoginSuccessHandler;
import com.mk.fitter.api.common.oauth.service.CustomOAuthUserService;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
	private final JwtService jwtService;
	private final UserRepository userRepository;
	private final CustomOAuthUserService customOAuthUserService;
	private final OAuth2LoginSuccessHandler successHandler;
	private final OAuth2LoginFailureHandler failureHandler;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
			.formLogin().disable()    // FormLogin 사용x
			.httpBasic().disable()
			.cors()
			.configurationSource(corsConfigurationSource())
			.and()
			.csrf().disable()
			.headers().frameOptions().disable()
			.and()

			// 세션 사용하지 않음
			.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
			.and()
			.authorizeRequests()
			.antMatchers("/api/oauth2/**").permitAll() // 회원가입 접근 가능
			.antMatchers("/**", "/", "/css/**", "/images/**", "/js/**", "/favicon.ico", "/h2-console/**").permitAll()
			.anyRequest().authenticated() // 위의 경로 이외에는 모두 인증된 사용자만 접근 가능
			.and()
			// 소셜 로그인
			.oauth2Login()
			.successHandler(successHandler) // 동의하고 계속하기를 눌렀을 때 Handler 설정
			.failureHandler(failureHandler) // 소셜 로그인 실패 시 핸들러 설정
			.userInfoEndpoint().userService(customOAuthUserService); // customUserService 설정

		http.addFilterAfter(jwtAuthenticationProcessingFilter(), LogoutFilter.class);
		return http.build();

	}

	@Bean
	public CorsConfigurationSource corsConfigurationSource() {
		CorsConfiguration corsConfiguration = new CorsConfiguration();
		corsConfiguration.addAllowedMethod("*");
		corsConfiguration.addAllowedMethod(HttpMethod.OPTIONS);
		corsConfiguration.addAllowedHeader("*");
		corsConfiguration.addAllowedOrigin("*");
		corsConfiguration.setMaxAge(7200L);
		corsConfiguration.addExposedHeader("Authorization");
		corsConfiguration.addExposedHeader("Authorization-refresh");
		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/**", corsConfiguration);
		return source;
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

	@Bean
	public JwtAuthenticationProcessingFilter jwtAuthenticationProcessingFilter() {
		JwtAuthenticationProcessingFilter jwtAuthenticationFilter = new JwtAuthenticationProcessingFilter(jwtService,
			userRepository);
		return jwtAuthenticationFilter;
	}

}
