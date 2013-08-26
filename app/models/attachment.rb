class Attachment < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true

  attr_accessible :attachable_id, :attachable_type, :attachment, :attachment_cache

  mount_uploader :attachment, AttachmentUploader

  validates :attachment, presence: true, if: Proc.new {|a| a.attachable_type == "Document"}
end
