class Customer < ActiveRecord::Base
    belongs_to :user
    has_many :customer_attachments, :dependent => :destroy
    accepts_nested_attributes_for :customer_attachments, :reject_if => lambda { |a| a[:avatar].blank? }, :allow_destroy => true

end
