# Jenkins as Code

* Not meant for production, just for doing pipelines asap in your local

## Commands

`docker build -t jenkins-as-code:test .`
`docker-compose up`

## Notes

* pass the `JENKINS_ADMIN_ID` and `JENKINS_ADMIN_PASSWORD` to not have to create the user manually on the startup of jenkins

* have to create a `job` (groovy.override) in where to put our pipeline as code, this job can get the pipelines as code from a git repository, based on a path or/and branch

* basically seedJob -> groovy.override -> jenkinsfile

## Resources

[Blog of the Job DSL Example](https://remy-dewolf.medium.com/our-journey-to-continuous-delivery-chapter-3-automate-your-configuration-with-jenkins-dsl-1ff14d7de4c4)
[Job DSL Example](https://github.com/Ticketfly/jenkins-docker-examples/tree/master/02-job-dsl)
[Job DSL pipelineJob](https://jenkinsci.github.io/job-dsl-plugin/#path/pipelineJob-definition-cpsScm)

## TODO

- [x] get first pipeline as code
