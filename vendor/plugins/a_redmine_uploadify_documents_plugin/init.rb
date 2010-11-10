# Include hook code here
 
require 'redmine'

Redmine::Plugin.register :a_redmine_uploadify_documents_plugin do
 name 'Document Uploadify Documents'
 author 'Gordon B. Isnor'
 description 'Uploadify for documents'
 version '0.0.1'
 permission :manage_uploadify_documents, {:uploadify_documents => [:new, :add_attachment]}, :require => :loggedin

end
