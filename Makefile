TAG=dbt-data-runner

build:
	docker build --build-arg COREDW_RO_PASSWORD=${COREDW_RO_PASSWORD} -t $(TAG) .

run:
	touch $(HOME)/.gitconfig
	touch $(HOME)/.bash_history
	docker run -it \
			   --rm \
			   --entrypoint=bash \
			   -e HISTFILE=/app/.bash_history \
			   -v $(HOME)/.bash_history:/app/.bash_history \
			   -v $(HOME)/.aws/credentials:/root/.aws/credentials \
			   -e USER \
			   -e AWS_DEFAULT_REGION \
			   $(TAG)
