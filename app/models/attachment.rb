class Attachment < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true

  attr_accessible :attachable_id, :attachable_type, :attachment

  mount_uploader :attachment, AttachmentUploader
end
