package Projet.Flutter.Authentification.Authentification.config;

import Projet.Flutter.Authentification.Authentification.entitys.AppUSER;
import Projet.Flutter.Authentification.Authentification.reposetory.UserReposetory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import java.util.ArrayList;

@Configuration
@EnableWebSecurity
public class configuration {
    @Autowired
    UserReposetory reposetory;
    @Bean
    public SecurityFilterChain SecurityFilterChain(HttpSecurity http) throws Exception {
        return http.csrf(csrf->csrf.disable())
                .authorizeRequests(auth->auth.anyRequest().permitAll())
                .sessionManagement(sess->sess.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .build();

    }
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider p=new DaoAuthenticationProvider();
        p.setUserDetailsService(userDetailsService());
        p.setPasswordEncoder(passwordEncoder());
        return p;
    }
    @Bean
    public UserDetailsService userDetailsService(){
        return new UserDetailsService() {
            @Override
            public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
                AppUSER user=reposetory.findByEmail(email);
                if (user==null) throw new RuntimeException("Cet utilisateur n'existe pas.");
                UserDetails Useer=new User(user.getEmail(),user.getPassword(),new ArrayList<>());
                return Useer;
            }
        };
    }
}
