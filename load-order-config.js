loadOrder.config = {

  // Where your application lives.
  // Must be inside `private` directory.
  sourceFolder: 'private/app',

  // Where your application will be "compiled" to.
  // Exclude this directory from code editor.
  targetFolder: '_app',

  // Settings for instructions.
  // If file contains instructions then
  // `getLocus` will be ignored for this file.
  instructions: {
    client: 'for client',
    server: 'for server',
    shared: 'for both'
  },

  // Should return number from 0 to 9.
  // 0 files are loaded first, 9 files are loaded last.
  getLoadOrderIndex: function(filepath, filename, ext) {
    return 0;
  },

  // Should return 'client', 'server' or 'shared'
  getLocus: function(filepath, filename, ext) {
    return 'client';
  }

};
