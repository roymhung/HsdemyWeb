package Hsdemy.vn.HsdemyWeb;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.security.autoconfigure.SecurityAutoConfiguration;
import org.springframework.boot.security.autoconfigure.actuate.web.servlet.ManagementWebSecurityAutoConfiguration;

@SpringBootApplication(
		exclude = {SecurityAutoConfiguration.class, ManagementWebSecurityAutoConfiguration.class})
public class HsdemyWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(HsdemyWebApplication.class, args);
	}

}
