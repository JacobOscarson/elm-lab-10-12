.PHONY: install
install:
	elm-package install

.PHONY: clean
clean:
	rm -rf elm-stuff

.PHONY: reinstall
reinstall: clean install

.PHONY: start
start:
	elm-live Main.elm --open --pushstate --output=elm.js
