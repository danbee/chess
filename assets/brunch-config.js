exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: {
        "js/app.js": /^js/,
        "js/vendor.js": /^(?!js)/,
      },
    },
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        after: ["web/static/css/app.css"], // concat app.css last
      },
    },
    templates: {
      joinTo: "js/app.js",
    },
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/,
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],

    // Where to compile files to
    public: "../priv/static",
  },

  // Configure your plugins
  plugins: {
    sass: {
      mode: "native",
    },
    babel: {
      presets: [
        [
          "@babel/preset-env", {
            useBuiltIns: "entry",
            targets: {
              phantomjs: "2.1.1",
            },
          },
        ],
        "@babel/preset-react",
      ],
      ignore: [/vendor/],
    },
  },

  overrides: {
    production: {
      optimize: true,
      sourceMaps: false,
      plugins: {
        sass: {
          mode: "native",
        },
        babel: {
          presets: [
            [
              "@babel/preset-env", {
                useBuiltIns: "entry",
                targets: {
                  firefox: "52",
                  chrome: "57",
                  safari: "10.3",
                  edge: "16",
                },
              },
            ],
            "@babel/preset-react",
          ],
          ignore: [/vendor/],
        },
      },
    },
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"],
    },
  },

  npm: {
    enabled: true,
  },
};
