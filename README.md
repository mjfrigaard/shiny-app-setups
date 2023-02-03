
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `shiny-app-setups`

<!-- badges: start -->
<!-- badges: end -->

The goal of shiny-app-setups is to compare setups for 1) R packages, 2)
`golem` shiny apps, and 3) a `rhino` apps.

All projects were created in the RStudio IDE (with the default options
selected).

## R packages

When creating a new package in the IDE, I provide a name and the parent
folder. New packages default to using `renv` and creating a git repo.

<img src="img/rpkg-setup.png" width="100%" height="100%" />

### Folder structure

<!-- tree myRPkg -L 5 -->

``` bash
myRPkg
  ├── DESCRIPTION
  ├── NAMESPACE
  ├── R
  │   └── hello.R
  ├── man
  │   └── hello.Rd
  ├── myRPkg.Rproj
  └── renv
      ├── activate.R
      ├── sandbox
      │   └── R-4.2
      │       └── x86_64-apple-darwin17.0
      │           └── 84ba8b13
      └── settings.dcf

8 directories, 7 files
```

### `DESCRIPTION` file

    Package: myRPkg
    Type: Package
    Title: What the Package Does (Title Case)
    Version: 0.1.0
    Author: Who wrote it
    Maintainer: The package maintainer <yourself@somewhere.net>
    Description: More about what it does (maybe more than one line)
        Use four spaces when indenting paragraphs within the Description.
    License: What license is it under?
    Encoding: UTF-8
    LazyData: true

## `golem` projects

<img src="img/golem-setup.png" width="100%" height="100%" />

### Folder structure

<!-- tree myGolemApp -L 5 -->

``` bash
myGolemApp
    ├── DESCRIPTION
    ├── NAMESPACE
    ├── R
    │   ├── app_config.R
    │   ├── app_server.R
    │   ├── app_ui.R
    │   └── run_app.R
    ├── dev
    │   ├── 01_start.R
    │   ├── 02_dev.R
    │   ├── 03_deploy.R
    │   └── run_dev.R
    ├── inst
    │   ├── app
    │   │   └── www
    │   │       └── favicon.ico
    │   └── golem-config.yml
    ├── man
    │   └── run_app.Rd
    ├── myGolemApp.Rproj
    ├── renv
    │   ├── activate.R
    │   ├── sandbox
    │   │   └── R-4.2
    │   │       └── x86_64-apple-darwin17.0
    │   │           └── 84ba8b13
    │   └── settings.dcf
    └── renv.lock

12 directories, 17 files
```

### `DESCRIPTION` file

    Package: myGolemApp
    Title: An Amazing Shiny App
    Version: 0.0.0.9000
    Authors@R: 
        person(given = "firstname",
               family = "lastname",
               role = c("aut", "cre"),
               email = "your@email.com")
    Description: What the package does (one paragraph).
    License: What license is it under?
    Imports: 
        config (>= 0.3.1),
        golem (>= 0.3.5),
        shiny (>= 1.7.4)
    Encoding: UTF-8
    LazyData: true
    RoxygenNote: 7.1.1

## `rhino` projects

<img src="img/rhino-setup.png" width="100%" height="100%" />

### Folder structure

``` bash
myRhinoApp
    ├── app
    │   ├── js
    │   │   └── index.js
    │   ├── logic
    │   │   └── __init__.R
    │   ├── main.R
    │   ├── static
    │   │   └── favicon.ico
    │   ├── styles
    │   │   └── main.scss
    │   └── view
    │       └── __init__.R
    ├── app.R
    ├── config.yml
    ├── dependencies.R
    ├── myRhinoApp.Rproj
    ├── renv
    │   ├── activate.R
    │   ├── library
    │   │   └── R-4.2
    │   │       └── x86_64-apple-darwin17.0
    │   ├── sandbox
    │   │   └── R-4.2
    │   │       └── x86_64-apple-darwin17.0
    │   └── settings.dcf
    ├── renv.lock
    ├── rhino.yml
    └── tests
        ├── cypress
        │   └── integration
        │       └── app.spec.js
        ├── cypress.json
        └── testthat
            └── test-main.R

18 directories, 17 files
```

### `config.yml` file

    default:
      rhino_log_level: !expr Sys.getenv("RHINO_LOG_LEVEL", "INFO")
      rhino_log_file: !expr Sys.getenv("RHINO_LOG_FILE", NA)

### `rhino.yml` file

    sass: node
