getAllFiles  = loadOrder.helpers.getAllFiles
deleteFolder = loadOrder.helpers.deleteFolder
sourceFolder = loadOrder.config.sourceFolder
targetFolder = loadOrder.config.targetFolder
processFile  = loadOrder.processFile

deleteFolder(targetFolder)
getAllFiles("#{sourceFolder}/**/*.*").forEach(processFile)
