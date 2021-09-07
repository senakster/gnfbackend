class LinksController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "p4ssword"

    def create
    @group = Group.find(params[:group_id])
    @link = @group.links.create(link_params)
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @link = @group.links.find(params[:id])
    @link.destroy
    redirect_to group_path(@group)
  end
  
  private
    def link_params
      params.require(:link).permit(:linkname, :url)
    end
end
