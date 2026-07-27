#let base_url = "https://img.shields.io/badge/"

#let icon_header(icon, header, fallback) = {
  if icon != "" and header != "" [
    #icon #header
    // has icon, no header
  ] else if icon != "" and header == "" [
    #icon About Me
    // no icon, has header
  ] else if icon == "" and header != "" [
    #header
    // no icon, no header
  ] else [
    #if fallback != "" [
      #fallback
    ] else [
      #""
    ]
  ]
}

#let get_icon(url: "", name: "", style: "") = {
  let url = if url != "" { url } else { base_url }
  let url = if url.ends-with("/") { url } else { url + "/" }
  let style = "flat"
  let color = "000000"

  let url_component = (url + "-" + name + "-" + color + "?style=" + style + "&logo=" + name)
  str(url_component.replace(" ", "%20"))
}

// Emit a string as raw HTML that survives the typst -> pandoc -> markdown pipeline.
// pandoc's typst reader discards the `lang` attribute on raw(), so we tag the
// payload with a sentinel prefix that scripts/gh-html.lua strips and rewrites to
// RawInline(html). This avoids pandoc backtick-wrapping our HTML (which GitHub
// would then show as literal text).
#let gh_html(s, block: false) = {
  raw("@@GH_HTML@@" + s, block: block)
}

#let render_item(base_url: "", name: "", style: "") = {
  let get_icon = get_icon.with(url: base_url)
  let icon_url = get_icon(name: name, style: style)
  // link(icon, name) ///// this works! (no icon tho)

  // icon URL
  let as_link = "<a href='" + icon_url + "'><img src='" + icon_url + "' alt='" + name + "' /></a>"
  gh_html(as_link)
}

// #let render_gh_stat(stat_url: "") = {
#let render_gh_stat(stat_url) = {
  // Emit inline HTML <img> via gh_html() so pandoc's typst reader passes it
  // through as raw HTML (like the shields.io badges). Using typst image() makes
  // pandoc rewrite the remote URL to a broken local path.
  let as_img = "<img src=\"" + stat_url + "\" alt=\"GitHub Stat\" />"
  gh_html(as_img)
}

#let github_profile(
  general: (
    name: "",
    mixed_name: "",
  ),
  github: (
    icon: "",
    name: "",
    url: "",
    personal_repo: "",
  ),
  lanyard: (
    name: "",
    url: "",
    link: "",
  ),
  // enabled_sections: (),
  sect_intro,
  sect_about,
  sect_languages,
  sect_technologies,
  // sect_lanyard,
  sect_gh_stats,
  sect_skyline,
  sect_contact,
  sect_sponsorship,
) = {
  set document(title: general.mixed_name + "'s GitHub Profile")
  set text(10pt, font: "JetBrainsMono NF") // Reverted to PT Sans to avoid potential issues; change back if needed
  set page(margin: (x: 1.2cm, y: 1.2cm))
  set par(justify: false)

  show heading.where(level: 1): hdr => text(18pt, [ #{ hdr.body } #v(4pt)])
  show heading.where(level: 2): hdr => text(14pt, [#{ hdr.body } #v(4pt)])
  show heading.where(level: 3): hdr => text(14pt, [#{ hdr.body } #v(4pt)])
  show heading.where(level: 4): hdr => text(12pt, [#{ hdr.body } #v(4pt)])
  show heading.where(level: 5): hdr => text(10pt, weight: "bold", [#{ hdr.body } #v(4pt)])

  let sections = (
    [ #sect_intro ],
    [ #sect_about ],
    [ #sect_languages ],
    [ #sect_technologies ],
    [ #sect_gh_stats ],
    [ #sect_skyline ],
    // [ #sect_lanyard ],
    // [ #sect_contact ],
    // [ #sect_sponsorship ],
  )

  let section_length = sections.len()

  for (idx, section) in sections.enumerate() [
    // #if enabled_sections.at(idx) != true [
    //   #continue
    // ]


    #if idx < section_length - 1 [
      #section
      #line(length: 100%, stroke: 0.5pt)
    ] else {
      [#section]
    }
  ]

  v(0pt)
  link(github.url, github.name) + " | " + link(github.url + "/" + github.name)
  linebreak()
  linebreak()

  let fmt_lanyard = if lanyard != "" {
    "<a href='" + lanyard.link + "'><img src='" + lanyard.url + "' alt='" + lanyard.name + "' /></a>"
  } else {
    ""
  }
  let raw_link = gh_html(fmt_lanyard)
  [#raw_link]
}

#let render_skyline(stl_url: "") = {
  // GitHub can't render .stl inline in markdown (an <img> would be broken), and
  // strips <script> embeds. So we link to the committed .stl — clicking opens
  // GitHub's native 3D viewer on the file page.
  gh_html("<a href=\"" + stl_url + "\">View my GitHub skyline (3D)</a>")
}
