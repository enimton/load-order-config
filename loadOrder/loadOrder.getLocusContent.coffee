readFile     = loadOrder.helpers.readFile
instructions = loadOrder.config.instructions
isInstructed = loadOrder.config.isInstructed

trim = (string) ->
  return string.replace(/^\s+|\s+$/g, '')

###*
# getIndentation('  Tester = {};')   => 2
# getIndentation('\t\tTester = {};') => 2
# @param {String} string
# @returns {Number}
###
getIndentation = (string) ->
  indent = 0

  for char in string
    if char isnt ' ' and char isnt '\t'
      break
    indent += 1

  return indent

###*
# getInstruction
('// for both')   => 'shared'
# getInstructionLocus('// for server') => 'server'
# getInstructionLocus('// forserver')  => null
# @param {String} line
# @param {String} commentBegin ('//'|'#')
# @returns {String|null} Locus provided by instruction
###
getInstructionLocus = (line, commentBegin) ->
  commentBegin = "#{commentBegin} "
  line = trim(line)

  if line.indexOf(commentBegin) is 0
    lineComment = line.replace(commentBegin, '')

    for locus, comment of instructions
      if comment is lineComment
        return locus

  return null

loadOrder.getLocusContent = (filepath, filename, ext) ->
  if not instructions or not isInstructed(filepath, filename, ext)
    return null

  commentBegin = { js: '//', coffee: '#' }[ext]
  filecontent = readFile(filepath)

  # If has no instructions in file content
  if not (
    filecontent.indexOf("#{commentBegin} #{instructions.client}") >= 0 or
    filecontent.indexOf("#{commentBegin} #{instructions.server}") >= 0 or
    filecontent.indexOf("#{commentBegin} #{instructions.shared}") >= 0
  )
    return null

  contentFor = { client: [], server: [] }
  locusIndentationMap = { 0: 'shared' }

  for line in filecontent.split('\n')
    indent = getIndentation(line)
    locus = getInstructionLocus(line, commentBegin)

    if locus
      locusIndentationMap[indent] = locus
    else
      while not locus
        locus = locusIndentationMap[indent]
        indent -= 1

      if locus is 'shared'
        contentFor.client.push(line)
        contentFor.server.push(line)
      else
        contentFor[locus].push(line)

  return {
    client: contentFor.client.join('\n')
    server: contentFor.server.join('\n')
  }
