class PreUser < ActiveRecord::Base
  scope :unread, -> { where(is_read: false) }

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Email"]
      all.each do |pre_user|
        csv << [pre_user.email]
      end
    end
  end
end