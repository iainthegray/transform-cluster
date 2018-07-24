## Jobs
This single file is a test parameterised nomad jobfile

### Command

`nomad job run -address=$NOMAD test_job.hcl`

`nomad job dispatch -address=$NOMAD -meta "s3_file=[s3 url]" transform`
