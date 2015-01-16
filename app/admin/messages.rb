ActiveAdmin.register WebMessage do
  index do
    column "Expert" do |web_message|
      twitter_handle = web_message.expert.twitter_handle

      link_to twitter_handle, user_path("@#{twitter_handle}"), target: "_blank"
    end
    column "Client" do |web_message|
      if web_message.user.present?
        twitter_handle = web_message.user.twitter_handle

        link_to twitter_handle, "http://twitter.com/#{twitter_handle}", target: "_blank"
      end
    end
    column "Client name", :full_name
    column "Client email", :email
    column :body
  end
end
