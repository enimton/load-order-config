minify       = require('uglify-js').minify
coffeeToJs   = require('coffee-script').compile
readFileSync = require('fs').readFileSync
writeFile    = require('fs').writeFileSync
getAllFiles  = require('glob').sync

readFile = (filepath) ->
  return readFileSync(filepath, { encoding: 'utf-8' })

packageFiles = [
  'loadOrder/loadOrder.helpers.coffee'
  'loadOrder/loadOrder.config.isInstructed.coffee'
  'loadOrder/loadOrder.getLocusContent.coffee'
  'loadOrder/loadOrder.processFile.coffee'
  'loadOrder/loadOrder.--Process-all-files.coffee'
]

# Minify all package code to 'load-order.min.js'
writeFile(
  'load-order.min.js',
  minify(
    coffeeToJs(
      (readFile(f) for f in packageFiles).join('\n\n').replace(/loadOrder\./g, 'this.loadOrder.')
    ),
    { fromString: true }
  ).code
)
