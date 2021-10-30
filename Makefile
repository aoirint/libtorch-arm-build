PLATFORM=linux/arm32v7
BUILD_OPTS=--config Release --parallel --build_shared_lib

.PHONY: build
build:
	docker buildx build . --platform "$(PLATFORM)" -t libtorch

.PHONY: run
run:
	docker run --rm -v "$(PWD)/build:/pytorch/build" --platform "$(PLATFORM)" libtorch bash -c "mkdir build_libtorch && cd build_libtorch && python3 ../tools/build_libtorch.py $(BUILD_OPTS)"
