# HolyImages

[![](https://api.travis-ci.org/crispgm/holy-images.svg?branch=master)](https://travis-ci.org/crispgm/holy-images)
[![Maintainability](https://api.codeclimate.com/v1/badges/41867af362501c3d9b17/maintainability)](https://codeclimate.com/github/crispgm/holy-images/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/41867af362501c3d9b17/test_coverage)](https://codeclimate.com/github/crispgm/holy-images/test_coverage)

HolyImages is a simple image sharing social network.

## Features

* Image Upload
* Image Explore
* EXIF Data
* Likes & Comments
* User System
* Notifications

## Plan

- [ ] Filters

## Setup

1. Install dependencies
	* ImageMagick
	* libexif
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
	$ RAILS_SERVE_STATIC_FILES=true PORT=9876 bin/rails server -e production -d
	```
