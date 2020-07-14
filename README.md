# Compilation

```bash
pandoc -t beamer bash.md -o bash.pdf -V theme:metropolis -V aspectratio:169 --highlight-style=espresso -H codeformat.tex
```

# Tips to myself

Using { .allowframebreaks } breaks slide into pieces

Using ::: block creates a block of text