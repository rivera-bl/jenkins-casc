# Jenkins as Code

* Not meant for production, just for doing pipelines asap in your local

## Commands

`docker build -t jenkins-as-code:test .`
`docker-compose up`

## Notes

* if we don't pass the `JENKINS_ADMIN_ID` and `JENKINS_ADMIN_PASSWORD` we will have to create the user manually on the startup of jenkins

## TODO

- [ ] get first pipeline as code
