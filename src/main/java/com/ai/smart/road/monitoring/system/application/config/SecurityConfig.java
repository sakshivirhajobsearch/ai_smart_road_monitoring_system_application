package com.ai.smart.road.monitoring.system.application.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.ai.smart.road.monitoring.system.application.service.UserDetailsServiceImpl;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

	private final UserDetailsServiceImpl userDetailsService;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		http.csrf(csrf -> csrf.disable())

				.authorizeHttpRequests(
						auth -> auth.requestMatchers("/login", "/css/**", "/images/**", "/js/**").permitAll()

								.requestMatchers("/admin/**").hasRole("ADMIN").requestMatchers("/collector/**")
								.hasRole("COLLECTOR").requestMatchers("/municipal/**").hasRole("MUNICIPAL")
								.requestMatchers("/pwd/**").hasRole("PWD").requestMatchers("/user/**").hasRole("USER")

								.anyRequest().authenticated())

				.formLogin(login -> login.loginPage("/login").loginProcessingUrl("/login")
						.defaultSuccessUrl("/dashboard", true).failureUrl("/login?error=true").permitAll())

				.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/login?logout=true").permitAll())

				// use only UserDetailsServiceImpl
				.userDetailsService(userDetailsService)

				.httpBasic(Customizer.withDefaults());

		return http.build();
	}

	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
		return config.getAuthenticationManager();
	}

	@Bean
	public static NoOpPasswordEncoder passwordEncoder() {
		return (NoOpPasswordEncoder) NoOpPasswordEncoder.getInstance();
	}
}
