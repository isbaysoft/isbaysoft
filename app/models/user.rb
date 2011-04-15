class User < ActiveRecord::Base
  before_save :check_sa
  
  has_many :static_contents
  has_many :tickets
  belongs_to :usergroup
  belongs_to :rule
  cattr_reader :per_page
  validates_presence_of :rule_id
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.([a-z]){2,4})$/

  attr_protected :rule_id
  attr_protected :access
  cattr_accessor :levels

  named_scope :allowobjects, lambda {|cu,list_ids|
    {:conditions => ['id <> ? and id in (?) and rule_id >= ?',cu.id,list_ids,cu.rule_id]
    }}
  named_scope :activated, :conditions => ['access = ?',true]
  named_scope :deactivated, :conditions => ['access = ?',false]

  @@per_page=30

  # Method _activate_ activates the user account.
  # Set access = true in table User.
  #
  # Example: Enable user with ID=1
  #  User.find(1).activate
  def activate
    self.access = true
    reset_perishable_token!
    Regnotification.deliver_user_activated(self) if save
  end

  # Method _deactivate_ disables the user account.
  # Set access = false in table User.
  #
  # Example: Disable user with ID=1
  #  User.find(1).deactivate
  def deactivate
    self.access = false
    reset_perishable_token!
    Regnotification.deliver_user_deactivated(self) if save
  end

  def destroy_valid?
    not superuser?
  end

  def destroy
    if destroy_valid?
      super
    else
      false
    end
  end

  acts_as_authentic do |c|
      c.validate_email_field = true
      c.validate_login_field = false
      c.validates_length_of_password_field_options  :minimum => 3, :if => :require_password?
  end

  self.levels = {
    "Sa" => 1,
    "Administrator" => 2,
    "Moderator" => 3,
    "Member" => 4
  }

  def rule_name
    self.rule.present? ? self.rule.name : "rule is missing. please do rake db:seed"
  end

  self.levels.default = 1

  def allow(level)
    self.rule_id <= levels[level.capitalize.to_s ]
  end

  def superuser?
    self.id == 1
  end

  def superadmin?
    self.rule_id == 1
  end

  def admin?
    self.rule_id <= 2
  end

  def moderator?
    self.rule_id <= 3
  end

  def check_sa
    # first user as Super Administrator
    if User.count == 0
      self.rule_id = 1 
      self.access = true
    end
  end  
  
  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['email like ?',"%#{options[:filter]}%"] if options[:filter]
    User.paginate :page =>page, 
      :select => 'usergroups.name as usergroup_name,
        rules.name as rule_name,
        users.*',
      :joins => 'left join usergroups on usergroups.id=users.usergroup_id 
        join rules on rules.id=users.rule_id',
      :conditions => filter,
      :order => options[:order]
  end

end
