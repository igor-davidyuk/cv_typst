#let data = toml("data.toml")
#let settings = toml("settings.toml")

#set page(
  paper: settings.page.paper_format,
  margin: (x: 1.8cm, y: 1.5cm),
)
#set text(
  // font: settings.font.name,
  font: "DejaVu Sans",
  size: eval(settings.font.size.description),
  lang: "en",
  weight: 600,  // 400 is default
)
#set par(
  leading: 0.5em,
  justify: false,
)

// #show link: underline

#show heading.where(level: 2): h => [
  #set text(
    // font: "Linux Biolinum",
    size: eval(settings.font.size.heading),
  )
  #v(6pt)
  #upper(h.body)
  #v(4pt, weak: true)
  #line(length: 100%)
  #v(0.6em, weak: true)
  
]

#let name_section = [
  #block()[
    #set text(size: eval(settings.font.size.name))
    #data.contacts.name
  ]
  // #align(bottom)[#data.summary.target_position]
  #data.summary.target_position
]
#let contacts_section = [
  #let email_sign = if settings.document.use_emoji {emoji.email} else [Email:]
  #let phone_sign = if settings.document.use_emoji {emoji.phone} else [Phone:]
  #let location_sign = if settings.document.use_emoji {emoji.map} else [Location:]
  #let github_sign = if settings.document.use_emoji {box(image("GitHub_logo.png", height: 0.8em))} else [GitHub:]
  #let linkedin_sign = if settings.document.use_emoji {box(image("LinkedIn_logo.png", height: 0.8em))} else [LinkedIn:]

  #grid(
    columns: 2,
    align: (right, left),
    column-gutter: 0.6em,
    row-gutter: 0.6em,
    // Content
    email_sign, link({"mailto:" + data.contacts.email}),
    phone_sign, data.contacts.phone,
    location_sign, data.contacts.address,
    github_sign, link({"https://github.com/" + data.contacts.github})[#data.contacts.github],
    linkedin_sign, link({"https://linkedin.com/in/" + data.contacts.linkedin})[#data.contacts.linkedin],
  )
]
#let profile_section = [
  #let entries = for (key, value) in data.profile{
    ([*#key:*], value,)
  }
  #grid(
    columns: 2,
    gutter: 1em,
    align: (right, left),
    ..entries
)
]

#let experience_section = [
  #for entry in data.experience [
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.7em,
      align: (left, right),
      [*#entry.position*], entry.location,
      link(entry.company.website)[#entry.company.name],
      entry.start_date +" - "+ entry.end_date
    )
    #v(0.7em)
    #set list(indent: 1em)
    #for point in entry.details [
      - #point
    ]
  ]
]

#let education_section = [
  #for entry in data.education [
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.7em,
      align: (left, right),
      [*#entry.degree* in #entry.major], entry.location,
      link(entry.university.website)[#entry.university.name],
      entry.start_date +" - "+ entry.end_date
    )
  ]
]


#grid(
  columns: (1.8fr, 1fr),
  // gutter: 2em,
  name_section,
  contacts_section
)
== Profile
#profile_section

== Experience
#experience_section

== Education
#education_section




// TODO:
// 1. Automate career duration calculation
// #datetime.today().display()
// #let date = datetime(
//   year: 2019,
//   month: 10,
//   day: 1,
// )
// #{calc.floor((datetime.today() - date).days() / 365.2425)}

// 2.