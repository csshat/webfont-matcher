# require main module (defined as `main` in package.json)
{matchFont} = require '..'


describe 'Webfont matcher', ->
  it 'should do nothing when font name is missing', ->
    expect(matchFont('omg')).toEqual([])

  it 'should find typekit font', ->
    expect(matchFont('Proxima Nova').length).toEqual(1)

  it 'should find typekit font by removing spaces', ->
    expect(matchFont('TisaPro').length).toEqual(1)

  it 'should normalize typekit font name', ->
    expect(matchFont('Proxima Nova')[0].name).toEqual('proxima-nova')

  it 'should find google font and typekit', ->
    expect(matchFont('Droid Sans').length).toEqual(2)
