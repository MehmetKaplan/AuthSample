#Since we are making view task in the controller, which is a bad thing ;-)...
include ActionView::Helpers::TextHelper

class SessionsController < ApplicationController
	def create
		auth = request.env['omniauth.auth']

		#render :text => request.env['rack.auth'].inspect
		render :text =>  "<html><body>" +
				"<p><b>You can use the data in this returned hash. The info fields are coming from provider (facebook for our example):</b></p><nobr><p>" + simple_format(JSON.pretty_generate(request.env)) + "</p><hr>" +
				"<nobr><nobr><b>TEST AREA</b>" + simple_format(JSON.pretty_generate(request.env['omniauth.auth'])) + " " +
				"<p>" + "uid: " + request.env['omniauth.auth']['uid'] + "</p>" +
				"<p>" + "provider: " + request.env['omniauth.auth']['provider'] + "</p>" +
				"<p>" + "name: " + request.env['omniauth.auth']['info']['name'] + "</p>" +
				"<p>" + "image: " + "<image src='" + request.env['omniauth.auth']['info']['image'] + "'></img>" + "</p>" +				
				"</body></html>"
	end

	def create_
		auth = request.env['rack.auth']
		unless @auth = Authorization.find_from_hash(auth)
			# Create a new user or add an auth to existing user, depending on
			# whether there is already a user signed in.
			@auth = Authorization.create_from_hash(auth, current_user)
		end
		# Log the authorizing user in.
		self.current_user = @auth.user

		render :text => "Welcome, #{current_user.name}."
	end

	def mytest
		render :text => ENV['FB_MOCMON_Test1_ID']
	end
	
end
