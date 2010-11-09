class UploadsController < ApplicationController
  unloadable
    
  def create
    begin
      d = Document.first
      a = Attachment.new(:container => d, :file => params[:Filedata], :description => '', :author => User.current)
      render :json => a.to_json if a.save
    rescue => e
      logger.info "RESCUE FROM UPLOADIFY ERROR: #{e}"
    end
  end
          
end
