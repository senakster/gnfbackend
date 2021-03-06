class GroupsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "p4ssword"
  # , except: [:index, :show]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to root_path
  end

  private
    def group_params
      params.require(:group).permit(:name, :grouptype, :municipality, :description)
    end
end
