package Config.config;

import com.mysql.cj.xdevapi.SessionFactory;
import jdk.jfr.Enabled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.convert.Property;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.orm.hibernate5.SessionFactoryUtils;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import javax.sql.DataSource;
import java.util.Properties;

@org.springframework.context.annotation.Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.project_spring.Admin")
@EnableTransactionManagement
public class Configuration implements WebMvcConfigurer {
    @Autowired
    Environment environment;

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource bundleMessageSource = new ReloadableResourceBundleMessageSource();
        bundleMessageSource.setBasename("classpath:messages");
        bundleMessageSource.setDefaultEncoding("utf-8");
        return bundleMessageSource;
    }

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(ConfigDataBase.Driver);
        dataSource.setUrl(ConfigDataBase.URL);
        dataSource.setUsername(ConfigDataBase.USERNAME);
        dataSource.setPassword(ConfigDataBase.PASSWORD);
        dataSource.setSchema(ConfigDataBase.SCHEMA);
        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate() {
        return new JdbcTemplate(dataSource());
    }

//    @Bean
//    public LocalSessionFactoryBean localSessionFactoryBean() {
//        LocalSessionFactoryBean bean = new LocalSessionFactoryBean();
//        bean.setDataSource(dataSource());
//        bean.setPackagesToScan("com.project_spring.Admin");
//
//        Properties properties = new Properties();
//        properties.put("hibernate.dialect", environment.getProperty("hibernate.dialect"));
//        properties.put("hibernate.show_sql", environment.getProperty("hibernate.show_sql"));
//
//        bean.setHibernateProperties(properties);
//        return bean;
//    }
//
//    @Bean(name = "transactionManager")
//    @Autowired
//    public HibernateTransactionManager hibernateTransactionManager(Session sessionFactory) {
//        HibernateTransactionManager hibernateTransactionManager = new HibernateTransactionManager();
//        hibernateTransactionManager.setSessionFactory(sessionFactory);
//        return hibernateTransactionManager;
//    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resource/**").addResourceLocations("/resources/");
        WebMvcConfigurer.super.addResourceHandlers(registry);
    }
}
