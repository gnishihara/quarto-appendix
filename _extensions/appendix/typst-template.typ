#let appendix(
  title: none,
  subtitle: none,
  running-head: none,
  authors: (),
  affiliations: none,
  citation: none,
  date: none,
  branding: none,
  leading: 0.6em,
  spacing: 1em,
  first-line-indent: 0cm,
  linkcolor: black,
  margin: (x: 3.2cm, y: 3cm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: ("Times New Roman", "Arial"),
  fontsize: 11pt,
  section-numbering: none,
  figprefix: none,
  toc: false,
  toc-title: "contents",
  toc-depth: none,
  toc-indent: 1.5em,
  bibliography-title: "References",
  bibliography-style: "apa",
  doc,
) = {

  /* Heavily modified after https://github.com/mvuorre/quarto-preprint */
  /* Document settings*/

  // Set link and cite colors
  show link: set text(fill: linkcolor)
  show cite: set text(fill: linkcolor)

  // Allow custom title for bibliography section
  set bibliography(title: bibliography-title, style: bibliography-style)

  // Bibliography paragraph spacing
  show bibliography: set par(spacing: spacing, leading: leading) if sys.version >= version(0, 12, 0)
  show bibliography: set block(spacing: leading) if sys.version < version(0, 12, 0)

  // Format author strings here, so can use in author note
  let author_strings = ()
  if authors != none {
    for a in authors {
      let author_string = box[#{
        // Solo manuscripts don't have institutional id
        a.name
        if authors.len() > 1 {super(a.affiliation)}
        }
        ]
      author_strings.push(author_string)
    }
  }

  // Page settings (including headers & footers)
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header-ascent: 30%,
    header: context {
      let pageN = counter(page).at(here()).first()
      if (pageN != 1) {
        return {
          grid(
            columns: (1fr, 1fr),
            align(left)[#running-head],
            h(0cm)
          )
        }
      } 
      return
    },
    footer-descent: 10%,
    footer: context {
      let pageN = counter(page).at(here()).first()
      if (pageN != 1) {
        return {
          grid(
            columns: (1fr, auto, 1fr),
            h(0cm),
            align(center, text(0.95em, str(pageN))),
            h(0cm)
          )
        }
      }
      return
    }
  )

  // Paragraph settings
  set par(
    justify: true,
    leading: leading,
    first-line-indent: first-line-indent
  )

  // Set space between paragraphs
  if sys.version >= version(0,12,0) {
    set par(spacing: spacing)
  } else {
    show par: set block(spacing: spacing)
  }

  // Text settings
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize
  )

  // Headers
  set heading(
    numbering: section-numbering
  )
  
  // Level 1 heading
  show heading.where(level: 1): it => block(width: 100%, below: 1em, above: 1.25em)[
    #set text(size: 1.25em, weight: "bold")
    #it
  ]
  
  // Level 2 heading
  show heading.where(level: 2): it => block(width: 100%, below: 1em, above: 1.25em)[
    #set text(size: 1.1em, weight: "bold")
    #it
  ]
  
  // Level 3 heading
  show heading.where(level: 3): it => block(width: 100%, below: 0.8em, above: 1.2em)[
    #set text(size: 1em, weight: "bold")
    #it
  ]
  
  // Level 4 & 5 headers are in paragraph
  show heading.where(level: 4): it => box(
    inset: (top: 0em, bottom: 0em, left: 0em, right: 1em),
    text(size: 1em, weight: "bold", it)
  )
  show heading.where(level: 5): it => box(
    inset: (top: 0em, bottom: 0em, left: 0em, right: 1em),
    text(size: 1em, weight: "bold", style: "italic", it)
  )

  /* Content front matter */

  let titleblock(
    body,
    width: 100%,
    size: 2em,
    weight: "bold",
    above: 1em,
    below: 2em
  ) = [
    #set par(justify: false)
    #align(left)[
      #block(width: width, above: above, below: below)[
        #text(weight: weight, size: size, hyphenate: false)[#body]
      ]
    ]
  ]

  if title != none {
    titleblock(title)
  }

  if subtitle != none {
    titleblock(
      weight: "regular",
      [#subtitle]
    )
  }

  if authors != none {
    titleblock(
      weight: "regular", size: 1.25em,
      [#author_strings.join(", ", last: " & ")]
    )
  }


  if affiliations != none {
    titleblock(
      weight: "regular", size: 1.1em, below: 2em,
      
      for a in affiliations [
        #show "Co.~": [Co.#sym.space.nobreak.narrow]

        #if affiliations.len() > 1 [#super[#a.id]]#if a.keys().contains("department") [#a.department]#if a.keys().contains("name") [, #a.name]#if a.keys().contains("region") [, #a.region]#if a.keys().contains("postal-code") [ #a.postal-code]#if a.keys().contains("country") [, #a.country]\
      ]
    )
  }


  // Table of contents
  if toc {
    let title = if toc-title == none {
      auto
    } else {
      toc-title
    }
    block(inset: (top: 2em, bottom: 0em, left: 2.4em, right: 2.4em))[
      #outline(
        title: toc-title,
        depth: toc-depth,
        indent: toc-indent
      )
    ]
  }

  
  /* Figure and Table*/

  show figure: set block(above: 2em, below: 2em)
  
  // Add a prefix to the figure numbering.
  show figure: set figure(numbering: n => {
    [#figprefix] + "-" + str(n)
  })
  
  show figure: set text(size: 1em)
  show figure: set figure.caption(position: top)
  show figure.caption: set align(left)

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): set align(left)
  
  pagebreak(weak: true) // Place a pagebreak between the front-matter and the body.

  /* Content */
  doc

}
