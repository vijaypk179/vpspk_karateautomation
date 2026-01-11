import com.intuit.karate.core.MockServer;

public class MockServerRunner {

    public static void main(String[] args) {
        MockServer
                .feature("classpath:mockserver/user-mock.feature")
                .http(8080)
                .build();
    }
}