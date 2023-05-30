
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `shiny-app-setups`

<!-- badges: start -->
<!-- badges: end -->

`shiny-app-setups` contains setups for 1) A vanilla shiny app
(`vanilla-shiny`), 2) an app built as an R package (`duap`), 2) a
`golem` shiny app (`gap`) 3) a `leprechaun` app (`lap`), and 4) a
`rhino` app (`rap`).

All projects were created in the console and/or in the RStudio IDE (with
the default options selected).

## Basic shiny app

Building a shiny app from **RStudio’s New Project Wizard** results in
the following folder structure.

<img src="img/vanilla-setup.png" width="70%" height="70%" style="display: block; margin: auto;" />

### Folder structure

``` bash
vanilla-shiny/
        ├── vanilla-shiny.Rproj
        ├── app.R
        ├── movies.RData
        ├── renv
        │   ├── activate.R
        │   ├── library
        │   │   └── R-4.2
        │   ├── sandbox
        │   │   └── R-4.2
        │   ├── settings.dcf
        │   └── staging
        ├── renv.lock
        └── utils.R

7 directories, 7 files
```

## R App (as a package)

From the console, packages are built using `devtools` and `usethis`.

The function for building a new package is `usethis::create_package()`

``` r
install.packages("devtools")
library(devtools)
Loading required package: usethis
usethis::create_package(path = "duap")
```

When creating a new package in the IDE, I provide a name and the parent
folder. New R packages use `roxygen2` (`roxygen = TRUE`) and check the
package name (`check_name = TRUE`), and default to using `renv` and
create a git repo.

<img src="img/rpkg-setup.png" width="70%" height="70%" style="display: block; margin: auto;" />

### Folder structure

<!-- tree myRPkg -L 5 -->

``` bash
duap/
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

``` bash
cat duap/DESCRIPTION
```

## `golem` projects

From the console, `golem` apps are also packages and are built using
`golem::create_golem()`:

``` r
install.packages("golem")
library(golem)
golem::create_golem(path = "gap")
```

When creating a new `golem` package in the IDE, I provide the name and
the parent folder.

New `golem` packages automatically perform a check on the name of the
package (`check_name = TRUE`).

<img src="img/golem-setup.png" width="70%" height="70%" style="display: block; margin: auto;" />

### Folder structure

<!-- tree gap -L 5 -->

``` bash
gap
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
    ├── gap.Rproj
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

    Package: gap
    Title: An example goelm app
    Version: 0.0.0.9000
    Authors@R: 
        person("Martin", "Frigaard", , "mjfrigaard@pm.me", role = c("cre", "aut"))
    Description: A working example of the golem package.
    License: MIT + file LICENSE
    Imports: 
        config (>= 0.3.1),
        ggplot2,
        golem (>= 0.3.5),
        pkgload,
        shiny (>= 1.7.4),
        stringr
    Suggests: 
        covr,
        spelling,
        testthat (>= 3.0.0)
    Config/testthat/edition: 3
    Encoding: UTF-8
    Language: en-US
    LazyData: true
    RoxygenNote: 7.2.3
    Depends: 
        R (>= 2.10)

## `leprechaun` projects

`leprechaun` apps are built using the same methods as R packages
(`devtools` and `usethis`).

``` r
usethis::create_package("lap")
```

After the new project opens, install and load the `leprechaun` package,
then run `leprechaun::scaffold()`:

``` r
install.packages("leprechaun")
library(leprechaun)
leprechaun::scaffold()
```

When creating a new `leprechaun` package in the IDE, it’s identical to
the R package setup.

<img src="img/leprechaun-setup.png" width="70%" height="70%" style="display: block; margin: auto;" />

### Folder structure

``` bash
lap/
      ├── DESCRIPTION
      ├── NAMESPACE
      ├── R
      │   ├── _disable_autoload.R
      │   ├── assets.R
      │   ├── input-handlers.R
      │   ├── leprechaun-utils.R
      │   ├── run.R
      │   ├── server.R
      │   ├── ui.R
      │   └── zzz.R
      ├── inst
      │   ├── assets
      │   ├── dev
      │   ├── img
      │   └── run
      │       └── app.R
      └── lap.Rproj
      
      7 directories, 12 files
```

### `DESCRIPTION` file

    Package: lap
    Title: Build Your Shiny App using leprechaun
    Version: 0.1.0
    Author: Martin Frigaard
    Maintainer: Martin Frigaard <mjfrigaard@pm.me>
    Description: This shiny app was developed as a package using the leprechaun 
        framework.
    License: MIT + file LICENSE
    Encoding: UTF-8
    Roxygen: list(markdown = TRUE)
    RoxygenNote: 7.2.3
    Imports: 
        bslib,
        htmltools,
        shiny
    Suggests: 
        packer,
        pkgload,
        sass
    Depends: 
        R (>= 2.10)
    LazyData: true

## `rhino` projects

From the console, `rhino` apps not packages (they use
[`box`](https://klmr.me/box/)), and are built using `rhino::init()`:

``` r
install.packages("rhino")
library(rhino)
rhino::init(dir = "rap")
```

When creating a new `rhino` package in the IDE, I provide the name and
the parent folder.

New `rhino` packages automatically create GitHub Actions Continuous
Integration (`github_actions_ci = TRUE`).

<img src="img/rhino-setup.png" width="70%" height="70%" style="display: block; margin: auto;" />

### Folder structure

``` bash
rap
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
    ├── rap.Rproj
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
