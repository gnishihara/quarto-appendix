# Appendix Format

quarto-appendix is a Quarto extension to rended Quarto source documents to PDF using Typst.


## Install

Add template to an existing project:

```bash
quarto add gnishihara/quarto-appendix`
```

Start a new Quarto project that uses `quarto-appendix`:

```bash
quarto use template gnishihara/quarto-appendix
```


## Configuration

The output of Quarto documents is configured through YAML metadata either in the 
document front matter (between triple dashes), or in a `_quarto.yml` file.

Read more at the Quarto [guide](https://quarto.org/docs/authoring/front-matter.html).
Also see the Quart Typst format [documentation](https://quarto.org/docs/output-formats/typst.html),
and the [Typst documentation](https://typst.app/docs) pages.


## Options specific to `quarto-appendix`

```{yaml}
running-head: "Appendix 1"
figprefix: "A1"

```

`running-head` should be a text string and is used as the running head for the document.

`figprefix` is a prefix that will be added to both figure and table captions.

