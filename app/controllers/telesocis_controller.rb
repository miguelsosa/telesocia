# Controller for Telesoci REST routes
class TelesocisController < ApplicationController
  before_action :set_telesoci, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
  def index
    @telesocis = Telesoci.all
  end

  def show
    respond_with(@telesoci)
  end

  def new
    @telesoci = Telesoci.new
  end

  def edit
  end

  def create
    @telesoci = Telesoci.new(telesoci_params)
    if @telesoci.save
      redirect_to @telesoci
    else
      # TODO: Fix error in new when validation fails - being called as POST
      render 'new'
    end
  end

  def update
    if @telesoci.update(telesoci_params)
      redirect_to @telesoci
    else
      render 'edit'
    end
  end

  def destroy
    @telesoci.destroy
    redirect_to telesocis_path, notice: 'Telesoci was successfully destroyed.'
  end

  private
  def set_telesoci
    @telesoci = Telesoci.find(params[:id])
  end
  
  def telesoci_params
    params.require(:telesoci).permit(:phone, :nickname, :first_name,
              :last_name, :company_name, :email, :url, :notes)
  end
  
end
