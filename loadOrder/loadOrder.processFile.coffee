getExtension      = loadOrder.helpers.getExtension
getFilename       = loadOrder.helpers.getFilename
copyFile          = loadOrder.helpers.copyFile
createFile        = loadOrder.helpers.createFile
pathResolve       = loadOrder.helpers.pathResolve
targetFolder      = loadOrder.config.targetFolder
getLocus          = loadOrder.config.getLocus
isInstructed      = loadOrder.config.isInstructed
getLoadOrderIndex = loadOrder.config.getLoadOrderIndex
getLocusContent   = loadOrder.getLocusContent

loadOrder.processFile = (filepath) ->
  filename = getFilename(filepath)
  ext = getExtension(filepath)
  loadOrderIndex = String(getLoadOrderIndex(filepath, filename, ext))
  locusContent = getLocusContent(filepath, filename, ext)

  if locusContent
    for locus, content of locusContent
      createFile(
        pathResolve(targetFolder, locus, loadOrderIndex, filename),
        content
      )
  else
    copyFile(
      filepath,
      pathResolve(targetFolder, getLocus(filepath, filename, ext), loadOrderIndex)
    )
