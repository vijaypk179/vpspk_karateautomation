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
     githubToken: 'replacetoken'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

karate.log(config)
  return config;
}