module SimpleTeams
  class Invitation < ApplicationRecord
    belongs_to :team
    belongs_to :inviter
    belongs_to :membership

    # validations
    validates_presence_of :email, :role
    validates_format_of :email, :with => URI::MailTo::EMAIL_REGEXP
    validate :email_uninvited, :on => :create

    # callbacks
    before_validation :format_email
    before_create :generate_token
    before_create :set_expiration
    after_create :send_invitation_notification
    after_update :send_invitation_notification, :if => :saved_change_to_email?

    # scopes
    scope :expired, -> { where("? > expires_at", Time.now) }
    scope :unexpired, -> { where("? <= expires_at", Time.now) }

    # enums
    enum role: [:member, :administrator, :owner]
    enum status: [:initial, :accepted, :declined]

    def expired?
      Time.now > expires_at
    end

    def unexpired?
      Time.now <= expires_at
    end

    def reset_invitation_token
      generate_token
      set_expiration
      self.save
    end

    def resend_invitation_notification(options = {})
      if Time.now > expiration - self.class.expiration_window + 1.day
        reset_invitation_token
      end
      send_invitation_notification(options)
    end

    def self.expiration_window
      2.weeks
    end

    private

    def format_email
      self.email = self.email.downcase.strip if email.present?
    end

    def generate_token
      self.token = SecureRandom.hex(32)
    end

    def set_expiration
      self.expires_at = Time.now + self.class.expiration_window
    end

    def send_invitation_notification(options = {})
      if options[:now] == true
        SimpleTeams::Mailer.invitation_notification(self).deliver_now
      else
        SimpleTeams::Mailer.invitation_notification(self).deliver_later
      end
    end

    def email_uninvited
      if team.members.map { |m| m.email }.include?(email)
        self.errors.add :email, "A person with this email address is already a member of this team."
        return false
      elsif team.invitations.initial.where(:email => email).present?
        self.errors.add :email, "A person with this email address has already been invited to this team."
        return false
      end
    end

  end
end
