package com.ewolff.microservice.customer;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Configuration
class SpringRestDataConfig implements RepositoryRestConfigurer {

	 @Override
         public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
             config.exposeIdsFor(Customer.class);

    }
}
