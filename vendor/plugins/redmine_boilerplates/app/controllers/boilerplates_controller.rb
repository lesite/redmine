class BoilerplatesController < ApplicationController
  layout 'admin'
  before_filter :require_admin
  unloadable
  before_filter :find_boilerplate, :only => [:edit,:update,:destroy]
  
  def index
    @boilerplates = Boilerplate.all
  end

  def new
    @boilerplate = Boilerplate.new
  end  
  
  def edit
  end
      
  def create
    @boilerplate = Boilerplate.new(params[:boilerplate])
    if @boilerplate.save
      redirect_to boilerplates_path
    else
      render :action => :new
    end  
  end
        
  def update
    if @boilerplate.update_attributes(params[:boilerplate])
      redirect_to boilerplates_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @boilerplate.destroy
    flash[:notice] = "Template Destroyed"
    redirect_to boilerplates_path  
  end
    
  private

    def find_boilerplate
      @boilerplate = Boilerplate.find(params[:id])
    end
    
end