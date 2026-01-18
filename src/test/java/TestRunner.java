import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.io.File;
import net.masterthought.cucumber.Configuration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import com.intuit.karate.core.MockServer;

class TestRunner {

    private static MockServer mockServer;
    @BeforeAll
    static void startMock() {
        mockServer = MockServer
                .feature("classpath:mockserver/user-mock.feature")
                .http(8081)
                .build();

        System.out.println("Mock Server started on port 8081");
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features").tags("mockapitest")
                .outputCucumberJson(true)
                .parallel(5);
        //Cucumber Report
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

    }

    public static void generateReport(String karateOutputPath) {

        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Report-Name");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    @AfterAll
    static void stopMock() {
        if (mockServer != null) {
            mockServer.stop();
            System.out.println("Mock Server stopped");
        }
    }

}
