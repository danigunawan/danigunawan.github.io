push:
	git add . && git commit -m "[ADD POSTING] $(m)" && git push -u origin master
bundle:
	bundle install
build:
	bundle exec jekyll build
serve:
	bundle exec jekyll serve
