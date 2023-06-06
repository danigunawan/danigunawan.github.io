push:
	git add . && git commit -m "[ADD POSTING] $(m)" && git push -u origin master
bundle:
	bundle install
build:
	bundle exec jekyll build
serve:
	bundle exec jekyll serve
serve-unpublished:
	bundler exec jekyll serve --unpublished
deps:
	nvm use v12.22.1 && HOMEBREW_NO_AUTO_UPDATE=1 brew install gifsicle && npm insall marked@2.0.0 &&  npm install through2
