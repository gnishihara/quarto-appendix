#show: doc => appendix(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(running-head)$
  running-head: [$running-head$],
$endif$
$if(by-author)$
  authors: (
  $for(by-author)$
      ( 
        name: [$it.name.literal$],
        affiliation: [$for(it.affiliations)$$it.id$$sep$, $endfor$]
      ),
  $endfor$
  ),
$endif$

$if(affiliations)$
  affiliations: (
    $for(affiliations)$(
      id: "$it.id$",
      name: "$it.name$",
      $if(it.department)$department: "$it.department$",$endif$
      $if(it.region)$region: "$it.region$",$endif$
      $if(it.country)$country: "$it.country$",$endif$
      $if(it.postal-code)$postal-code: "$it.postal-code$"$endif$
    ),
    $endfor$
  ),
$endif$

$if(figprefix)$
  figprefix: "$figprefix$",
$endif$

$if(date)$
  date: [$date$],
$endif$
$if(leading)$
  leading: $leading$,
$endif$
$if(branding)$
  branding: "$branding$",
$endif$
$if(spacing)$
  spacing: $spacing$,
$endif$
$if(linkcolor)$
  linkcolor: $linkcolor$,
$endif$
$if(citation)$
  citation: (
    type: "$citation.type$",
    container-title: "$citation.container-title$",
    doi: "$citation.doi$",
    url: "$citation.url$"
  ),
$endif$

$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(section-numbering)$
  section-numbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-depth)$
  toc-depth: $toc-depth$,
$endif$
$if(toc-title)$
  toc-title: "$toc-title$",
$endif$
$if(toc-indent)$
  toc-indent: "$toc-indent$",
$endif$
$if(bibliography-style)$
  bibliography-style: [$bibliography-style$],
$endif$
$if(bibliography-title)$
  bibliography-title: [$bibliography-title$],
$endif$
  doc,
)
