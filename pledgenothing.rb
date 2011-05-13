require 'rubygems'
require 'isolate/now'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'padrino-helpers'
require 'padrino-mailer'
require 'haml'

class Pledge < ActiveRecord::Base
  validates_presence_of :name, :unless => :is_anonymous?
  validates_presence_of :pledge_years
  validates_numericality_of :pledge_years
  validates_inclusion_of :pledge_years, :in => 1..20, :message => 'must be between 1 and 20'
  validates_numericality_of :class_year, :allow_nil => true
  validates_inclusion_of :class_year, :in => 1920..2015, :message => 'must be between 1920 and 2015'

  class << self
    def most_recent(max = 1)
      order('created_at desc').limit(max)
    end
    
    def random
      find(rand(count)+1)
    end
  end
end

class PledgeNothing < Sinatra::Base
  register Padrino::Helpers
  register Padrino::Mailer

  def self.build_mailer
    mailer :test do
      email :testmail do |name|
        subject 'Test'
        to      'rick@rickbradley.com'
        from    'info@pledgenothing.org'
        locals  :name => name
        render  'test/testmail'
      end
    end
  end

  def setup_email
    return if @email_config_file
    @email_config_file = File.join(File.dirname(__FILE__), 'config', 'email.yml')
    if File.exists? @email_config_file
      @smtp_settings = YAML.load(File.read(@email_config_file))
      set :delivery_method, :smtp => @smtp_settings
    end
    self.class.build_mailer
  end
  
  get '/testmail' do
    setup_email
    deliver(:test, :testmail, "Bob Vila")
  end

  get '/' do
    @pledges = Pledge.most_recent
    haml :index
  end
  
  get '/randompledge' do
    @pledge = Pledge.random
    haml :random_pledge, :layout => false
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

