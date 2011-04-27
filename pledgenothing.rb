require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'padrino-helpers'
require 'haml'

class Pledge < ActiveRecord::Base
  validates_presence_of :name, :unless => :is_anonymous?
  validates_presence_of :pledge_years
  validates_numericality_of :pledge_years
  validates_inclusion_of :pledge_years, :in => 1..20, :message => 'must be between 1 and 20'
  validates_numericality_of :class_year, :allow_nil => true
  validates_inclusion_of :class_year, :in => 1920..2015, :message => 'must be between 1920 and 2015'
end

class PledgeNothing < Sinatra::Base
  register Padrino::Helpers

  get '/' do
    haml :index
  end

  get '/new' do
    @pledge = Pledge.new(:name => 'Your Name', :pledge_years => '5')
    haml :new_pledge, :layout => false
  end

  post '/create' do
    @pledge = Pledge.new(
      :name         => params[:name],
      :pledge_years => params[:pledge_years].to_i,
      :class_year   => params[:class_year].to_i, 
      :comments     => params[:comments],
      :email        => params[:email],
      :is_anonymous => params[:is_anonymous])

    if @pledge.save
      haml :thank_you, :layout => false
    else
      haml :new_pledge, :layout => false
    end
  end
end

