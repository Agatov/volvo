require 'sinatra/base'
require 'sinatra/assetpack'
require 'haml'
require 'sass'
require 'httparty'
require 'json'
require 'pony'
require 'i18n'


I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config', 'locales', '*.yml').to_s]

class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :sass, { :load_paths => [ "#{Application.root}/assets/stylesheets" ] }
  set :protection, :except => :frame_options

  register Sinatra::AssetPack

  assets {
    serve '/css', from: 'assets/stylesheets'
    serve '/images', from: 'assets/images'
    serve '/js', from: 'assets/javascripts'
    serve '/fonts', from: 'assets/fonts'

    css :application, '/css/application.css', %w(/css/style.css /css/jquery.bxslider.css /css/modal.css)
    js :application, '/js/application.js', %w( /js/jquery-1.9.1.js /js/html5shiv.js /js/jquery.bxslider.js /js/order.js /js/google_maps.js)

    css_compression :sass
    js_compression :jsmin
  }

  get '/' do
    erb :index, layout: :layout
  end

  post '/orders.json' do

    message = "#{params[:order][:username]}. #{params[:order][:phone]}"

    Pony.mail ({
      to: 'vsedlyavolvo@gmail.com',
      subject: I18n.t('email.title', locale: 'ru'),
      body: message,
      via: :smtp,
      via_options: {
        address: 'smtp.google.com',
        port: 587,
        enable_starttls_auto: true,
        user_name: 'vsedlyavolvo',
        password: 'moyparol',
        authentication: :plain
      }
    })

    content_type :json
    {status: :success}.to_json
  end
end