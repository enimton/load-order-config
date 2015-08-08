getExtension      = loadOrder.helpers.getExtension
getFilename       = loadOrder.helpers.getFilename
copyFile          = loadOrder.helpers.copyFile
pathResolve       = loadOrder.helpers.pathResolve
targetFolder      = loadOrder.config.targetFolder
getLocus          = loadOrder.config.getLocus
getLoadOrderIndex = loadOrder.config.getLoadOrderIndex

loadOrder.processFile = (filepath) ->
  filename = getFilename(filepath)
  ext = getExtension(filepath)

  copyFile(
    filepath,
    pathResolve(
      targetFolder,
      getLocus(filepath, filename, ext),
      String(getLoadOrderIndex(filepath, filename, ext))
    )
  )
