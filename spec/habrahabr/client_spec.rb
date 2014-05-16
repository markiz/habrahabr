# encoding: utf-8
require 'spec_helper'

module Habrahabr
  describe Client do
    subject { described_class.new(token: 'token', client_id: 'client_id') }

    describe "#hubs" do
      before do
        stub_request(:get, %r|/v1/hubs|).
            to_return(body: File.read('spec/fixtures/hubs.json'))
      end

      it "coerces response into ListResult of Hubs" do
        response = subject.hubs
        response.count.should == 40
        hub = response.first
        hub.should be_a(Entities::Hub)
        hub.alias.should == 'infosecurity'
      end

      it "contains pagination info" do
        response = subject.hubs
        response.pages_count.should == 9
        response.next_link.url.should == 'https://api.habrahabr.ru/v1/hubs?page=2'
      end
    end

    describe "#hub_habred" do
      before do
        stub_request(:get, %r|/v1/hub/\w+/habred|).
            to_return(body: File.read('spec/fixtures/hub_habred.json'))
      end

      it "coerces response into ListResult of Posts" do
        response = subject.hub_habred('php')
        response.count.should == 25
        post = response.first
        post.should be_a(Entities::Post)
        post.id.should == 221259
        post.title.should == 'Тестирование отдельных Symfony 2 бандлов'
      end

      it "contains pagination info" do
        response = subject.hub_habred('php')
        response.pages_count.should == 40
        response.next_link.url.should == 'https://api.habrahabr.ru/v1/hub/php/habred?page=2'
      end
    end

    describe "#post" do
      before do
        stub_request(:get, %r|v1/post/\d+|).
            to_return(body: File.read('spec/fixtures/post.json'))
      end

      it "returns a Post" do
        post = subject.post(220393)
        post.should be_a(Entities::Post)
        post.text_html.should include('Так же хорошо бы использовать не')
      end
    end

    describe "#posts_metadata" do
      before do
        stub_request(:get, %r|/v1/posts/meta|).
            to_return(body: File.read('spec/fixtures/posts_metadata.json'))
      end

      it "returns an array of posts" do
        response = subject.posts_metadata([221259, 75570])
        response.count.should == 2
        post = response.first
        post.should be_a(Entities::Post)
        post.id.should == 221259
      end

      it "ignores false values" do
        stub_request(:get, %r|/v1/posts/meta|).
            to_return(body: File.read('spec/fixtures/posts_metadata_with_false_values.json'))
        response = subject.posts_metadata([221259, 75570])
        response.count.should == 1
      end
    end

    describe "#post_comments" do
      before do
        stub_request(:get, %r|/v1/comments/\d+|).
            to_return(body: File.read('spec/fixtures/comments.json'))
      end

      it "returns a ListResult of Comments" do
        response = subject.post_comments('75570')
        response.count.should == 1
        comment = response.first
        comment.message.should include('Но иногда желательнее чтобы')
      end
    end
  end
end
