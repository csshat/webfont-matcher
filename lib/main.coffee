google = require '../fonts/google'
typekit = require '../fonts/typekit'

normalize = (str) ->
  str.toLowerCase().replace /( |-)/g, ''

matchFontInLibrary = (name, normalizedName, library) ->
  fonts = library.getNames().filter (font) ->
    name is font or normalizedName.indexOf(normalize(font)) > -1 or normalize(font).indexOf(normalizedName) > -1
  if fonts.length
    {library, name: fonts[0]}

matchFontInLibraries = (name, libraries) ->
  normalizedName = normalize(name)
  xf = (result, library) ->
    match = matchFontInLibrary(name, normalizedName, library)
    if match
      result.push(processFont(match))
    return result
  libraries.reduce(xf, [])

processFont = ({library, name}) ->
  return {
    libraryName: library.name
    libraryIcon: library.icon
    name: library.normalizeName(name)
    link: library.getLink(name)
  }

matchFont = (name) ->
  libraries = [typekit, google]
  matchFontInLibraries(name, libraries)


module.exports = {
  matchFontInLibraries
  matchFont
  libraries: {
    google
    typekit
  }
}
