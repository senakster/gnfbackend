class UploadsController < ApplicationController
   http_basic_authenticate_with name: "admin", password: "p4ssword"

    def index
        @groups = Group.all
        @uploads = Upload.all
    end
   def new
      @upload = Upload.new
   end
   
   def create
      @upload = Upload.new(upload_params)
      @data = JSON.parse(File.read('public' + @upload.attachment_url))
      @data["grupper"].each do |g|

         # ActiveRecord ALREADY CONTAINS GROUP
         if Group.exists?(name: g["navn"])
         group = Group.where(name: g["navn"]).first
         gd = group_data(g)
         if group.update(gd)
               puts g["navn"] + " " + "Updated!"
               add_links(g["links"], group)
         end
         # ActiveRecord DOES NOT CONTAIN GROUP
         else 
         gd = group_data(g)
         group = Group.new(gd)
            if group.save
               puts "#{group.id} #{group.name} Created!"
               add_links(g["links"], group)
            end
         end
      end
      FileUtils.rm_rf('public' + @upload.attachment_url)
      
      redirect_to uploads_path
      ## SAVE UPLOAD TO FILE##
      # if @upload.save
      #    redirect_to uploads_path, notice: "The file #{@upload.name} has been uploaded."
      # else
      #    render "new"
      # end
   end
   
   def destroy
      @upload = Upload.find(params[:id])
      @upload.destroy
      redirect_to uploads_path, notice:  "The file #{@upload.name} has been deleted."
   end
   
   private
      def upload_params
      params.require(:upload).permit(:name, :attachment)
      end      

      def group_params
      params.require(:upload).permit(:name, :municipality, :grouptype, :description)
      end

      def group_data(g)
         return {:name => g["navn"],
            :municipality => g["kommune"],
            :grouptype => g["type"],
            :description => g["beskrivelse"]
         }
      end

      def add_links(links, group)
            links.each do |l|
               name = l.kind_of?(String) ? "facebook" : l.linkname
               group.links.create({:linkname => name, :url => l})
            end
      end
end
