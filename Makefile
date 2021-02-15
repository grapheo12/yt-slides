regev.html: regev.md revealjs-template.html
	pandoc -t revealjs --mathjax --template=revealjs-template.html -s -o regev.html regev.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2

fhe.html: fhe.md revealjs-template.html
	pandoc -t revealjs --mathjax --template=revealjs-template.html -s -o fhe.html fhe.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2

vigenere.html: vigenere.md revealjs-template.html
	pandoc -t revealjs --mathjax --template=revealjs-template.html -s -o vigenere.html vigenere.md -V revealjs-url=https://unpkg.com/reveal.js@3.9.2