PLATFORM=linux/arm32v7
BUILD_OPTS=

.PHONY: build
build:
	docker buildx build . --platform "$(PLATFORM)" -t libtorch

.PHONY: run
run:
	docker run --rm \
		-v "$(PWD)/build_libtorch:/pytorch/build_libtorch" \
		--platform "$(PLATFORM)" \
		-e "BUILD_TEST=0" \
		-e "USE_CUDA=0" \
		-e "USE_MKLDNN=0" \
		-e "USE_DISTRIBUTED=0" \
		-e "CC=gcc-8" \
		-e "CXX=g++-8" \
		-w "/pytorch/build_libtorch" \
		libtorch python3 ../tools/build_libtorch.py $(BUILD_OPTS)
