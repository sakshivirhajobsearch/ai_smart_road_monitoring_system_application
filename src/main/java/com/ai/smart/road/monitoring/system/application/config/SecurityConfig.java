package com.ai.smart.road.monitoring.system.application.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(auth -> auth.requestMatchers("/login", "/css/**", "/js/**", "/images/**").permitAll()
				.requestMatchers("/dashboard/**", "/pothole/**", "/repair/**").authenticated())
				.formLogin(form -> form.loginPage("/login").defaultSuccessUrl("/dashboard", true).permitAll())
				.logout(logout -> logout.logoutSuccessUrl("/login?logout").permitAll()).csrf(csrf -> csrf.disable());

		return http.build();
	}

	@Bean
	public UserDetailsService userDetailsService(PasswordEncoder encoder) {
		UserDetails collector = User.withUsername("collector").password(encoder.encode("collector123"))
				.roles("COLLECTOR").build();

		UserDetails pwdDept = User.withUsername("pwd").password(encoder.encode("pwd123")).roles("PWD").build();

		UserDetails municipal = User.withUsername("municipal").password(encoder.encode("municipal123"))
				.roles("MUNICIPAL").build();

		return new InMemoryUserDetailsManager(collector, pwdDept, municipal);
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
