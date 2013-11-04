class IssueSerializer < ActiveModel::Serializer
  attributes :id, :title, :details, :site_id
end
