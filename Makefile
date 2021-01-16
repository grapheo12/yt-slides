vigenere.html: vigenere.md revealjs-template.html
	pandoc -t revealjs --mathjax --template=revealjs-template.html -s -o vigenere.html vigenere.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2