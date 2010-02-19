# Encoding: UTF-8

{
  fileTypes: ['txt', 'asciidoc'],
  name: 'AsciiDoc',
  patterns: [
    { name: 'entity.name.section.asciidoc',
      match: /^=+.*/, },
    { name: 'meta.tag.email.asciidoc',
      match: /(\w(\w|[.-])*)@(\w|[.-])*[0-9A-Za-z_.]/ },
    { name: 'keyword.other.asciidoc',
      match: /TODO|FIXME|XXX|ZZZ/ },
    { name: 'constant.character.backslash.asciidoc',
      match: /\\/ },
    { name: 'markup.underline.link.asciidoc',
      match: /(http|https|ftp|file|irc):\/\/[^|\s]*(\w|\/)/ },
  ],
  repository: {
  },
  scopeName: 'text.plain.asciidoc',
}
