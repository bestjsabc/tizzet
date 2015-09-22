module UserAuth
  def self.included(recipient)
    recipient.class_eval do
      before_save :encrypt_password

      # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
      def self.authenticate(login, password)
        u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
        u && u.authenticated?(password) ? u : nil
      end

      # Encrypts some data with the salt.
      def self.encrypt(password, salt)
        Digest::SHA1.hexdigest("--#{salt}--#{password}--")
      end

      # Encrypts the password with the user salt
      def encrypt(password)
        self.class.encrypt(password, salt)
      end

      def authenticated?(password)
        crypted_password == encrypt(password)
      end

      def remember_token?
        remember_token_expires_at && Time.now.utc < remember_token_expires_at
      end

      # These create and unset the fields required for remembering users between browser closes
      def remember_me
        remember_me_for 2.weeks
      end

      def remember_me_for(time)
        remember_me_until time.from_now.utc
      end

      def remember_me_until(time)
        self.remember_token_expires_at = time
        self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
        save(false)
      end

      def forget_me
        self.remember_token_expires_at = nil
        self.remember_token            = nil
        save(false)
      end

      # Returns true if the user has just been activated.
      def recently_activated?
        @activated
      end
  
      def create_reset_code
        @reset = true
        code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
        self.attributes = {:reset_code => code[0..6]}
        save(false)
      end

      def recently_reset?
        @reset
      end

      def delete_reset_code
        self.attributes = {:reset_code => nil}
        save(false)
      end
  
      def self.random_password(length=20)
        chars = ('a'..'z').to_a + (2..9).to_a # Leaving out 0 and 1, they look like capital 'i' and 'o' respectively.
        (1..length).map { chars.rand }.join # Pick 'length' random chars
      end
      

    protected

      # before filter
      def encrypt_password
        return if password.blank?
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
        self.crypted_password = encrypt(password)
      end

      def password_required?
        crypted_password.blank? || !password.blank?
      end

      def make_activation_code
        self.deleted_at = nil
        self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      end

      def do_activate
        @activated = true
        self.activated_at = Time.now.utc
        self.deleted_at = self.activation_code = nil
      end
      
    end
  end
end