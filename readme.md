# Introduction

Chainable APIs are great. There's no denying it. With Rails 3, ActiveRecord got a chainable API. But not so for ActiveResource, 
that red-headed stepchild of the Rails 'verse.

## Installation

It's a gem. Install it.

    $ gem install chaingang

## Usage

First, `include ChainGang` in your ActiveResource::Base derived client class.

    class Article < ActiveResource::Base
      self.site = 'http://blah.com'
      include ChainGang
    end

Then, go wild:

    # find all the articles 
    @articles = Article.find.all.from(:published).where.author("moonmaster9000").and.genre("sci-fi")
    
    # at this point, @articles hasn't actually made the network call yet. 
    @articles.each do |article| # now it's made the network call
      puts article.title
    end

    # or, find a specific article. this does not use a proxy.
    @articles = Article.find('moonmaster9000 makes another gem!')

    # or, find the first article by moonmaster9000 and immediately return the result
    @articles = Article.find.first.where.author("moonmaster9000").execute

## Documentation

Checkout http://rdoc.info/gems/chaingang/frames
