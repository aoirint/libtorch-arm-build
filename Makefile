.PHONY: build
build:
	docker buildx build . --platform linux/arm32v7 -t libtorch

.PHONY: run
run:
	docker run --rm -it libtorch

