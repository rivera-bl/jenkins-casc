# Jenkins as Code

* Not meant for production, just for doing pipelines asap in your local

## Commands

`docker build -t jenkins-as-code:test .`
`docker-compose up`

## Notes

* pass the `JENKINS_ADMIN_ID` and `JENKINS_ADMIN_PASSWORD` to not have to create the user manually on the startup of jenkins

* have to create a `job` (groovy.override) in where to put our pipeline as code, this job can get the pipelines as code from a git repository, based on a path or/and branch

* basically seedJob -> groovy.override -> jenkinsfile

* it's important to pass the `https` to the git>remote>github line, or it will complain about missing credentials

* how to get the name of the plugin to add it to the `plugins.txt` file?
    - go to the page of the plugin, for ex. [sonarqube scanner](https://plugins.jenkins.io/sonar/) and click on the 'How to Install' box to get its name and latest version
    - or search through [this page](https://archives.jenkins.io/plugins/)

* with sonarcloud it ain't necessary to configure a webhook, it automatically stops the pipeline if the quality gate ain met

* downsides of using sonarcloud is that we can't generate PDF reports, with sonarqube we can through a plugin

* if we are going to use sonarqube we have to make sure to have at least a 5% of our total disk drive available, because it uses elasticsearch as its default database

## DevSecOps Pipeline Example

* as part of the devsecops diploma of usach, I'll build a pipeline that:
    1. clone [this repo](https://github.com/PheaSoy/spring-boot-kubernetes)
    2. sast -> [sonarcloud](https://docs.sonarqube.org/7.9/analysis/scan/sonarscanner-for-jenkins/)
    3. sca  -> [DependencyCheck ](https://github.com/jeremylong/DependencyCheck)

### Walkthrough

1. fork the code repo so we can execute sonarcloud on it
2. install the `sonar` [plugin](https://plugins.jenkins.io/sonar/)
3. connect sonarcloud to your github account and create a `token`
4. add the token to a `jenkins credential`
5. add the repository as a project in sonarcloud, so we can use its values for the next step
6. configure the `sonar plugin` as detailed [here](https://igorski.co/sonarqube-scans-using-jenkins-declarative-pipelines/)
  - Add the Sonarqube Server location
  - Add the Sonarqube Scanner installation
7. allow the sonarcloud `github app` to have access the repository we are going to analyze
8. configure a quality gate for the project in sonarcloud

## Resources

### Job DSL

[Blog of the Job DSL Example](https://remy-dewolf.medium.com/our-journey-to-continuous-delivery-chapter-3-automate-your-configuration-with-jenkins-dsl-1ff14d7de4c4)
[Job DSL Example](https://github.com/Ticketfly/jenkins-docker-examples/tree/master/02-job-dsl)
[Job DSL pipelineJob](https://jenkinsci.github.io/job-dsl-plugin/#path/pipelineJob-definition-cpsScm)

### CASC

[Sample configs for plugins](https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos)
[Exported CASC](http://localhost:8080/configuration-as-code/viewExport)
TODO: get documentation 

### Sonarcloud

[Step a Step](https://igorski.co/sonarqube-scans-using-jenkins-declarative-pipelines/)

### DependencyCheck


## Utilities

[Jenkisfile syntax generator](https://opensource.triology.de/jenkins/pipeline-syntax/)

## Known Issues

- Passing the `secret` of `credentials` in `casc.yaml` as .env doesn't work, so you have to change it manually to the correct value after jenkins starts

## TODO

- [x] get first pipeline as code
- [x] configure sonarqube plugin in jenkins with CASC
    - sonarqube server detail (name, url)
    - sonarqube scanner install
- [x] add sonarcloud quality check
- [x] replace tokens for one thats not tracked in our commit history
- [x] create a credential in jenkins with CASC
  - [ ] find a way to pass secrets correctly

- [ ] trigger pipeline automatically when there is a new commit on the repo
    - for this should contain the Jenkinsfile and the app code into one repository
- [ ] find a way to test fast and locally the pipelines
- [ ] figure out how to create multiple pipelines from multiple folders, from a single groovy.override call
    - scriptPath('pipelines/*/Jenkinsfile') doesn't work
