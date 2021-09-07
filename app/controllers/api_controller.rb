class ApiController < ApplicationController

  def index
    raw = Group.all
    @groups = raw.map { |r| {**r.as_json(except: :description), links: format_links(r.links) } }
    render json: @groups
  end

  def show
    raw = Group.find(params[:id])
    @group = format_group(raw)
    render json: @group
  end

  private
    def group_params
      params.require(:group).permit(:name, :grouptype, :municipality, :link, :description)
    end

    def format_group(group)
      return {**group.as_json, links: format_links(group.links) }
    end

    def format_links(links)
      return links.map { |l| {linkname: l.linkname, url: l.url} }
    end
end
