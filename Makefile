.PHONY: up build clean new-post

up:
	docker-compose up

build:
	docker run --rm -v $(PWD):/src klakegg/hugo:latest

clean:
	docker run --rm -v $(PWD):/src klakegg/hugo:latest --cleanDestinationDir

new-post:
	docker run --rm -v $(PWD):/src klakegg/hugo:latest new posts/$(shell date +%Y-%m-%d)-new-post.md