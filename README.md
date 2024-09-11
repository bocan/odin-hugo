# About

This is a Dockerfile and a Github Action used to build a custom docker image of [Hugo](https://gohugo.io/) Extended for my purely Docker powered web stack.

The built images (for AMD64 and ARM64) are here: [https://hub.docker.com/r/bocan/odin-hugo](https://hub.docker.com/r/bocan/odin-hugo).

# Hugo Overview

Hugo is a [static site generator](https://en.wikipedia.org/wiki/Static_site_generator) written in [Go](https://go.dev/), optimized for speed and designed for flexibility. With its advanced templating system and fast asset pipelines, Hugo renders a complete site in seconds, often less.

Due to its flexible framework, multilingual support, and powerful taxonomy system, Hugo is widely used to create:

- Corporate, government, nonprofit, education, news, event, and project sites
- Documentation sites
- Image portfolios
- Landing pages
- Business, professional, and personal blogs
- Resumes and CVs

Use Hugo's embedded web server during development to instantly see changes to content, structure, behavior, and presentation. Then deploy the site to your host, or push changes to your Git provider for automated builds and deployment.

Hugo's fast asset pipelines include:

- Image processing &ndash; Convert, resize, crop, rotate, adjust colors, apply filters, overlay text and images, and extract EXIF data
- JavaScript bundling &ndash; Transpile TypeScript and JSX to JavaScript, bundle, tree shake, minify, create source maps, and perform SRI hashing.
- Sass processing &ndash; Transpile Sass to CSS, bundle, tree shake, minify, create source maps, perform SRI hashing, and integrate with PostCSS
- Tailwind CSS processing &ndash; Compile Tailwind CSS utility classes into standard CSS, bundle, tree shake, optimize, minify, perform SRI hashing, and integrate with PostCSS

And with [Hugo Modules](https://gohugo.io/hugo-modules/), you can share content, assets, data, translations, themes, templates, and configuration with other projects via public or private Git repositories.

See the [features](https://gohugo.io/about/features/) section of the documentation for a comprehensive summary of Hugo's capabilities.

# About this Extended version Docker Build

Hugo is available in two editions: standard and extended. With the extended edition you can:

* Encode to the WebP format when processing images. You can decode WebP images with either edition.
* Transpile Sass to CSS using the embedded LibSass transpiler. The extended edition is not required to use the Dart Sass transpiler.

I've based this Docker build from the work of [@jakejarvis](https://github.com/jakejarvis) and his [Dockerfile](https://github.com/jakejarvis/hugo-docker).  The final Alpine Linux container includes a few small third-party tools that are required by certain optional Hugo features:

* PostCSS
* Autoprefixer
* Babel
* Pygments
* Asciidoctor
* Pandoc
* Docutils / RST
* Embedded Dart Sass (amd64 only)
