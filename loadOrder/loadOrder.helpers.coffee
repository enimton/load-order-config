getFilename       = Npm.require('path').basename
extname           = Npm.require('path').extname
pathJoin          = Npm.require('path').join
pathResolve       = Npm.require('path').resolve
createReadStream  = Npm.require('fs').createReadStream
createWriteStream = Npm.require('fs').createWriteStream
createFolder      = Npm.require('mkdirp').sync
deleteFolder      = Npm.require('rimraf').sync
getAllFiles       = Npm.require('glob').sync

loadOrder.helpers =

  pathResolve: pathResolve
  getFilename: getFilename
  getAllFiles: getAllFiles
  deleteFolder: deleteFolder

  getExtension: (filepath) ->
    return extname(filepath)[1...]

  copyFile: (filepathFrom, directoryTo) ->
    createFolder(directoryTo)
    createReadStream(filepathFrom)
      .pipe(createWriteStream(pathJoin(directoryTo, getFilename(filepathFrom))))
