#import "github-profile.typ": github_profile, icon_header, render_gh_stat, render_item, render_method
#let conf = json("conf.jsonc")
// conf.at(section).at(inner) == true { true } else { false },

#let init_es = {
  conf
    .keys()
    .map(
      section => conf
        .at(section)
        .keys()
        .filter(
          inner => //
          if inner == "enabled" and conf.at(section).at(inner) == true {
            true
          } else {
            false
          },
        ),
    )
}

// #let es = { init_es.map(e => if e == () { false } else { true }) }

// TODO: Get the 'enabled' property working as intended

#github_profile(
  general: conf.general,
  github: conf.github,
  // enabled_sections: { init_es.map(e => if e == () { false } else { true }) },
  [

    #let partial_hdr = icon_header(
      conf.intro.icon,
      conf.intro.header,
      "Hi, I'm " + conf.general.mixed_name + " welcome!",
    )

    #if conf.intro.img_or_gif != "" [
      = #partial_hdr
      #[![](#conf.intro.img_or_gif)]
    ] else [
      = #partial_hdr
    ]

  ],
  [

    = #icon_header(conf.about.icon, conf.about.header, "About Me")
    #let bullet_array = ()
    #let length = conf.about.bullets.len()
    #if conf.about.bullets.len() > 0 [
      #for (idx, bullet) in conf.about.bullets.enumerate() [
        #if idx < length - 1 [
          #bullet_array.push("• " + bullet + linebreak())
        ] else [
          #bullet_array.push("• " + bullet)
        ]
      ]
      #bullet_array.join("")
    ] else [
      • Something might be broken... Classic really #linebreak()
    ]

  ],
  [

    === #icon_header(conf.languages.icon, conf.languages.header, "Languages & Tools")
    #let lang_array = ()
    #let ri = render_item.with(base_url: conf.languages.base_url)
    #let length = conf.languages.list.len()
    #for (idx, lang) in conf.languages.list.enumerate() [
      #let link = ri(name: lang.name, style: lang.style)
      #if idx < length - 1 [
        #lang_array.push(link + " ")
      ] else [
        #lang_array.push(link)
      ]
    ]
    #lang_array.join("")

  ],

  [

    === #icon_header(conf.technologies.icon, conf.technologies.header, "Technologies I use")
    #let tech_array = ()
    #let ri = render_item.with(base_url: conf.technologies.base_url)
    #let length = conf.technologies.list.len()
    #for (idx, tech) in conf.technologies.list.enumerate() [
      #let link = ri(name: tech.name, style: tech.style)
      #if idx < length - 1 [
        #tech_array.push(link + " ")
      ] else [
        #tech_array.push(link)
      ]
    ]
    #tech_array.join("")

  ],


  [

    === #icon_header(conf.gh_stats.icon, conf.gh_stats.header, "GitHub Stats: ")

    #let stats = conf.gh_stats.urls.first()
    #let langs = conf.gh_stats.urls.last()

    #grid(
      columns: 2,
      [ #render_gh_stat(stat_url: stats) ], [ #render_gh_stat(stat_url: langs) ],
    )

  ],
  [

    === #icon_header(conf.contact.icon, conf.contact.header, "Get in touch with me")
    #for method in conf.contact.methods [
      • #render_method(icon: method.icon, display_text: method.display_text, url: method.url)\
    ]
  ],

  [

    === #icon_header(conf.sponsorship.icon, conf.sponsorship.header, "Sponsor me! (If you'd like to)")
    #let method_array = ()
    #let length = conf.sponsorship.methods.len()
    #for (idx, method) in conf.sponsorship.methods.enumerate() [
      #let line = "• " + render_method(icon: method.icon, display_text: method.display_text, url: method.url)
      #if idx < length - 1 [
        #method_array.push(line + " ")
      ] else [
        #method_array.push(line)
      ]
    ]
    #method_array.join(" ")
  ],
)

