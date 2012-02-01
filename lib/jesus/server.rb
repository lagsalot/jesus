require 'sinatra/base'
require "jesus/interface"
require "jesus/server/helpers"
require 'json'


module Jesus
  class Server < Sinatra::Base
<<<<<<< HEAD
=======
    
>>>>>>> 43fd7e025e8c28ff87fd349b827776cf54068a58
    include Jesus::Helpers
    
    dir = File.dirname(File.expand_path(__FILE__))
    
<<<<<<< HEAD
    set :views, "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
=======
    set :root, "#{dir}/server"
    set :views, Proc.new { File.join(root,"views") }
    set :public_folder, Proc.new { File.join(root,"public") }
>>>>>>> 43fd7e025e8c28ff87fd349b827776cf54068a58
    set :static, true
    
    enable :sessions # required for flash
    
    
    #
    # The home
    # Displays the list of the process
    #
    get '/' do
      @status = Jesus::Interface.new.status
      show @status.nil? ? :error : :home
    end
    
    #
    # Displays a process log
    #
    get '/logs/:process' do
      @log = Jesus::Interface.new.log(params[:process])
      show @log.nil? ? :error : :log
    end
    
    #
    # Displays every page logs
    #
    get '/logs' do
      flash(:notice, 'You currently can not display all the logs. You should select a process first.')
      redirect '/'
    end
    
    #
    # Executes a command (start, restart, stop, quit or terminate) on the server
    #
    get '/command/:command/:process' do
      @command = Jesus::Interface.new.command(params[:command], params[:process])
      flash(:notice, 'The command ' + params[:command] + ' has successfully been executed. It might take a few seconds before the status process effectively changes.')
      redirect '/'
    end
    
    #
    # Displays every process and it's status in json format
    #
    get '/json' do
      Jesus::Interface.new.status.to_json
    end
  end
end