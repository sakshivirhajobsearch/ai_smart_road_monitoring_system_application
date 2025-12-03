// SecurityConfig.java
package com.ai.smart.road.monitoring.system.application.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private UserDetailsService userDetailsService; // your UserDetailsServiceImpl bean

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationSuccessHandler myAuthSuccessHandler() {
		SimpleUrlAuthenticationSuccessHandler h = new SimpleUrlAuthenticationSuccessHandler();
		h.setDefaultTargetUrl("/"); // redirect after login; change if you have role redirects
		h.setAlwaysUseDefaultTargetUrl(false);
		return h;
	}

	@Bean
	public DaoAuthenticationProvider authProvider() {
		DaoAuthenticationProvider ap = new DaoAuthenticationProvider();
		ap.setUserDetailsService(userDetailsService);
		ap.setPasswordEncoder(passwordEncoder());
		return ap;
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(authorize -> authorize
				.requestMatchers("/css/**", "/js/**", "/images/**", "/api/**", "/login", "/error").permitAll()
				.requestMatchers("/admin/**").hasRole("ADMIN").requestMatchers("/collector/**").hasRole("COLLECTOR")
				.requestMatchers("/municipal/**").hasRole("MUNICIPAL").anyRequest().authenticated())
				.formLogin(form -> form.loginPage("/login").successHandler(myAuthSuccessHandler()).permitAll())
				.logout(logout -> logout.permitAll()).authenticationProvider(authProvider());

		return http.build();
	}
}
