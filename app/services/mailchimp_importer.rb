class MailchimpImporter
  def initialize
    @gb = Gibbon::API.new(ENV['MAILCHIMP_API_KEY'])
  end

  def import
    users = User.approved.experts.not_included_in_mailchimp

    mailchimp_info = users.map do |user|
      {
        email: user.email,
        merge_vars: {
          NAME: user.full_name
        }
      }
    end

    @gb.lists.batch_subscribe(id: ENV['MAILCHIMP_LIST_ID'], batch: mailchimp_info, update_existing: false)
  
    # users.update_all(mailchimp_flag: true)
  end
end