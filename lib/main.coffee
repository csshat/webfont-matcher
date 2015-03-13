google = require '../fonts/google'
typekit = require '../fonts/typekit'

normalize = (str) ->
  str.toLowerCase().replace /( |-)/g, ''

matchFontInLibrary = (name, normalizedName, library) ->
  result = null
  for font in library.getNames()
    normalizedFont = normalize(font)

    if name is font or normalizedName is normalizedFont
      result = font
      break
    else if normalizedName.indexOf(normalizedFont) > -1 or normalizedFont.indexOf(normalizedName) > -1
      result = font

  if result
    {library, name: result}

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
