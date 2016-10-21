.PHONY: install
install:
	elm-package install

.PHONY: clean
clean:
	rm -rf elm-stuff

.PHONY: reinstall
reinstall: clean install

node_modules/clipboard/dist/clipboard.js:
	npm i clipboard

.PHONY: clipboardjs
clipboardjs: node_modules/clipboard/dist/clipboard.js

.PHONY: start
start:
	elm-live Main.elm --open --pushstate --output=elm.js
