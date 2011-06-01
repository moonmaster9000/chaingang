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

    # find all the articles /articles/published.xml?author=moonmaster9000&genre=sci-fi
    @articles = Article.find(:all).from(:published).where.author?("moonmaster9000").and.genre?("sci-fi")
    
    # at this point, @articles hasn't actually made the network call yet. 
    @articles.each do |article| # now it's made the network call
      puts article.title
    end

    # or, find a specific article by id, but add a "?preview_data=true" onto the query string.
    @article = Article.find('some-article-id').where.preview_data?(true)

    # or, find the first article by moonmaster9000 and get the title; /articles.xml?author=moonmaster9000
    @article = Article.find(:first).where.author?("moonmaster9000").title

    # to specifiy the reqeust format, you can use format() method, which temporarily set Article.format for this request.
    @article = Article.find(:first).where.author?("moonmaster9000").format(:json)         # or :xml

## Documentation

Checkout http://rdoc.info/gems/chaingang/frames
