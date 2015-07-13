class CustomerAttachment < ActiveRecord::Base
	belongs_to :customer
	mount_uploader :avatar, AvatarUploader
end
