isInstructed = loadOrder.config.isInstructed

if not isInstructed
  isInstructed = (filepath, filename, ext) ->
    return ext not in [ 'html', 'jade', 'css', 'less', 'sass' ]

loadOrder.config.isInstructed = isInstructed
