module SessionUtilities
	
	def valid_signin(user)
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"

		# Sign in when not using Capybara as well.
		cookies[:remember_token] = user.remember_token
	end
end
