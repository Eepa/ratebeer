class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      # haetaan usernamea vastaava käyttäjä tietokannasta
      user = User.find_by username: params[:username]
      # talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
    
      if user.nil? or user.password_digest.nil? or not user.authenticate params[:password] 
	redirect_to :back, notice: "Username and password do not match!"
      else

        session[:user_id] = user.id if not user.nil?
        # uudelleen ohjataan käyttäjä omalle sivulleen 
        redirect_to user, notice: "Welcome back!"
      end
    end

    def destroy
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end
end
