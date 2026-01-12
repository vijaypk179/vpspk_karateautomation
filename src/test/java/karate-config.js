function fn() {
  var env = karate.env; // get system property 'karate.env'
  var githubToken ="";
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    githubToken: 'replacetoken',
    baseUrl: 'https://www.saucedemo.com/'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

karate.configure('driver', {type: 'chrome',executablePath: 'src/test/java/resources/chromedriver.exe',headless: false,timeout: 30000,slowMo: 0,addOptions: ['--start-maximized','--disable-notifications','--disable-infobars']});
karate.configure('retry', { count: 3, interval: 2000 });
karate.log(config)
  return config;
}