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

#let render_item(base_url: "", name: "", style: "") = {
  let get_icon = get_icon.with(url: base_url)
  let icon_url = get_icon(name: name, style: style)
  // link(icon, name) ///// this works! (no icon tho)

  // icon URL
  let as_link = "<a href='" + icon_url + "'><img src='" + icon_url + "' alt='" + name + "' /></a>"
  raw(as_link)
}

#let render_gh_stat(stat_url: "") = {
  let as_link = "<a href='" + stat_url + "'><img src='" + stat_url + "' alt='GitHub Stat' /></a>"
  raw(as_link)
}

#let render_method(icon: "", display_text: "", url: "") = {
  let icon = if icon != "" { get_icon(name: icon) + " " } else { "" }
  let display_text = if display_text != "" { display_text } else { url }
  let url = if url != "" { url } else { "#" }
  let as_link = "<a href='" + url + "'>" + icon + display_text + "</a>"
  raw(as_link)
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
  lanyard: "",
  // enabled_sections: (),
  sect_intro,
  sect_about,
  sect_languages,
  sect_technologies,
  sect_gh_stats,
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
  link(github.url, github.name) + " | " + link(github.url + "/" + github.personal_repo, github.personal_repo)
  linebreak()
  linebreak()
  lanyard
}
