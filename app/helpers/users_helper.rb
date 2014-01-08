module UsersHelper

  #
  # Method: gravatar_for, it's used for getting the gravatar-account's images
  # Returns the Gravatar Icons for user
  #
  def gravatar_for(user, options = { size: 50})

      # checking the id of account which has existed into the Gravatar Site...
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}"

      # return the Avatar's account
      image_tag(url, alt: user.name, class: "gravatar")
  end
end
