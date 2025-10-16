#let data = toml("data.toml")
#let settings = toml("settings.toml")
#let accent_color = navy

#set page(
  paper: settings.page.paper_format,
  margin: (x: 1.8cm, y: 1.2cm),
)
#set text(
  font: settings.font.name,
  // font: "DejaVu Sans",
  size: eval(settings.font.size.description),
  lang: "en",
  weight: 400,  // 400 is default
)
#set list(
  spacing: 0.6em,
)
#set par(
  leading: 0.4em,
  justify: false,
)

#show link: set text(accent_color)

#let section_header(body, accent_color: accent_color) = {
  v(1em, weak: true)
  set text(
    size: eval(settings.font.size.heading),
    fill: accent_color,
  )
  // v(3pt)
  [#upper(body)]
  v(0.9em, weak: true)
}

///////////////////////////////// CONTENT

#let name_and_contacts_section = [
  #block()[
    #set text(size: eval(settings.font.size.name), accent_color, )
    #data.contacts.name
  ]

  #let contacts_list = (
    link({"mailto:" + data.contacts.email})[#data.contacts.email], 
    link({"https://github.com/" + data.contacts.github})[github.com/#data.contacts.github],
    link({"https://linkedin.com/in/" + data.contacts.linkedin})[linkedin.com/in/#data.contacts.linkedin],
    // link({"https://t.me/" + data.contacts.telegram})[#(data.contacts.telegram + "@telegram")],
  )
  #show link: set text(black)
  #text(black, size: eval(settings.font.size.contacts))[#contacts_list.join(" ")]
  #linebreak(justify: true)

]

#let position_and_summary_section = [
  #block()[
    #set text(size: eval(settings.font.size.heading_large), accent_color)
    #data.summary.target_position
  ]
  #data.summary.about\
  My publication list is available on #link(data.contacts.google_scholar)[Google Scholar].\
  #v(0.9em, weak: true)
  #text(accent_color)[*AI/ML*]: #data.summary.profile.at("AI/ML").join(", ")\
  #text(accent_color)[*Backend & APIs*]: #data.summary.profile.at("Backend & APIs").join(", ")\
  #text(accent_color)[*Infrastructure*]: #data.summary.profile.at("Infrastructure").join(", ")\
]

#let experience_section = [
  #section_header(accent_color: navy)[Work Experience]
  #for entry in data.experience [
    *#entry.position* #h(1fr) #entry.start_date - #entry.end_date\
    #entry.company.name
    #v(0.9em, weak: true)
    #set list(indent: 1em)
    #for point in entry.details [
      - #point
    ]
  ]
]

#let education_section = [
  #section_header(accent_color: navy)[Education]
  #for entry in data.education [
    *#entry.degree* in #entry.major #h(1fr) #entry.start_date - #entry.end_date\
    #entry.university.name\
    #v(0.4em)
  ]
]

#let location_section = [
  #section_header(accent_color: navy)[Location]
  I am currently located in #data.contacts.location. I am open to relocation and remote work opportunities including B2B contracts.
]

#name_and_contacts_section
#v(0.7em)
#position_and_summary_section
#v(0.7em)
#experience_section
#v(0.7em)
#education_section
#v(0.7em)
#if settings.document.add_location_footnote [
  #location_section
]

// hi #h(1fr) Hi

