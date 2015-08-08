minify       = require('uglify-js').minify
coffeeToJs   = require('coffee-script').compile
readFileSync = require('fs').readFileSync
writeFile    = require('fs').writeFileSync
getAllFiles  = require('glob').sync

utf8 = { encoding: 'utf-8' }

readFile = (filepath) ->
  return readFileSync(filepath, utf8)

filenames = [
  'loadOrder/loadOrder.helpers.coffee'
  'loadOrder/loadOrder.processScriptFile.coffee'
  'loadOrder/loadOrder.processStyleFile.coffee'
  'loadOrder/loadOrder.processTemplateFile.coffee'
  'loadOrder/loadOrder.processFile.coffee'
  'loadOrder/loadOrder.--Process-all-files.coffee'
]

writeFile(
  'load-order.min.js',
  minify(
    coffeeToJs(
      (readFile(f) for f in filenames).join('\n\n').replace(/loadOrder\./g, 'this.loadOrder.')
    ),
    { fromString: true }
  ).code
)
