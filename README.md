# HolyImages

[![](https://api.travis-ci.org/crispgm/holy-images.svg?branch=master)](https://travis-ci.org/crispgm/holy-images)
[![Maintainability](https://api.codeclimate.com/v1/badges/41867af362501c3d9b17/maintainability)](https://codeclimate.com/github/crispgm/holy-images/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/41867af362501c3d9b17/test_coverage)](https://codeclimate.com/github/crispgm/holy-images/test_coverage)

HolyImages is a simple image sharing social network.

_Notice_: the login system is for non-production only, without proper status check on server side.

## Features

* Image Upload (with Filters like Instagram)
* Image Explore
* EXIF Data
* Likes & Comments
* User System
* Notifications
* PC/Mobile friendly
* I18N Support (current with English and Simplified Chinese)

## Plan

* [x] Filters
* [ ] Editing & Deleting
* [ ] Follow
* [ ] Archive
* [ ] Sharing

## Screenshots

<p align="center">
  <img src="docs/screenshots/index.png" width="270" />
  <img src="docs/screenshots/explore.png" width="270" />
  <img src="docs/screenshots/upload.png" width="270" />
</p>

## Setup

1. Install dependencies
	* ImageMagick
	* libexif
    ```
    $ brew install imagemagick
    $ brew install libexif
    ```
2. Install gems
	```
	$ bundle install
	```
3. Setup `secrets.yml`
4. Create DB
	```
	$ bin/rails db:create
	$ bin/rails db:migrate
	```
5. Compile assets
	```
	$ RAILS_ENV=production rake assets:precompile
	```
6. Serve
	```
	$ RAILS_SERVE_STATIC_FILES=true PORT=<:port> bin/rails server -e production -d
	```

## License

MIT
