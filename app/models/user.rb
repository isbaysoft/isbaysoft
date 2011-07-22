class User < ActiveRecord::Base
  before_save :check_sa
  
  has_many :static_contents
  has_many :tickets
  belongs_to :usergroup
  belongs_to :rule, :foreign_key => 'access_level'
  cattr_reader :per_page
  validates_presence_of :access_level
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.([a-z]){2,4})$/

  attr_protected :access_level, :access
  cattr_accessor :levels

#  TODO переименовать в permitted
  named_scope :allowobjects, lambda {|cu,list_ids|
    {:conditions => ['id <> ? and id in (?) and access_level >= ?',cu.id,list_ids,cu.access_level]
    }}
  named_scope :activated, :conditions => ['access = ?',true]
  named_scope :deactivated, :conditions => ['access = ?',false]

  @@per_page=30

  def self.current=(user)
    @current_user = user
  end

  def self.current
    @current_user ||= User.anonymous
  end

  def self.anonymous
    anonymous_user = AnonymousUser.find(:first)
    if anonymous_user.nil?
      anonymous_user = AnonymousUser.create(:lastname => 'Anonymous', :firstname => '', :mail => '', :login => '', :status => 0)
      raise 'Unable to create the anonymous user.' if anonymous_user.new_record?
    end
    anonymous_user
  end


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
    "Sa" => 1000,
    "Administrator" => 900,
    "Moderator" => 800,
    "Member" => 700,
    "Everybody" => 0
  }

  def rule_name
    self.rule.present? ? self.rule.name : "rule is missing. please do rake db:seed"
  end

  self.levels.default = 1

  def allow(level)
    #TODO Проверить все проверки на доступ
    self.access_level >= levels[level.capitalize.to_s ]
  end
#TODO переделать это безобразие
  def superuser?
    self.id == 1
  end
#TODO переделать это безобразие
  def superadmin?
    self.access_level == 1000
  end
#TODO переделать это безобразие
  def admin?
    self.access_level >= 900
  end
#TODO переделать это безобразие
  def moderator?
    self.access_level >= 800
  end

  def anonymous?
    self.access_level = 0
  end

  def check_sa
    # first user as Super Administrator
    if User.count == 0
      self.access_level = 1000
      self.access = true
    end
  end  

#  TODO Переделать эту гадость - ...join rules on rules.access_l...
  def self.getrows(options)
    page = options[:page] || 1
    @@per_page = options[:per_page] || @@per_page
    filter = ['email like ?',"%#{options[:filter]}%"] if options[:filter]
    User.paginate :page =>page, 
      :select => 'usergroups.name as usergroup_name,
        rules.name as rule_name,
        users.*',
      :joins => 'left join usergroups on usergroups.id=users.usergroup_id 
        join rules on rules.access_level=users.access_level',
#      :conditions => filter,
      :order => options[:order]
  end

end

class AnonymousUser < User
  def validate_on_create
    # There should be only one AnonymousUser in the database
    errors.add_to_base 'An anonymous user already exists.' if AnonymousUser.find(:first)
  end

  def available_custom_fields
    []
  end

  # Overrides a User properties
  def id; 0 end
  def login; 'Anonymous' end
  def email; nil end
  def access; 1 end
  def access_level; 0 end
  def superuser?; false end
  def admin?; false end
  def moderator?; false end

  # Anonymous user can not be destroyed
  def destroy
    false
  end
end
