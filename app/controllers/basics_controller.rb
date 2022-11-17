class BasicsController < ApplicationController

  def index
    @profiles = Profile.all
  end

  def export_xml
    puts "exporting....................................................................."
  end

  def quotations
    @title = "Quotations"
    if params[:quotation]
      if (params[:new_category].present?)
        new_quote_params = quotation_params
        new_quote_params[:category] = params[:new_category]
      end
      @quotation = Quotation.new(new_quote_params)

      if @quotation.save
        flash[:notice] = "Quotation was successfully created."
        @quotation = Quotation.new
      end
    else
      @quotation = Quotation.new
    end

    if params[:favorite]
      add_to_favorites
    end

    if params[:remove_favorite]
      remove_from_favorites
    end

    if params[:clear]
      clear_favorites
    end

    if params[:sort_by] == "date"
      @quotations = Quotation.order(:created_at)
    else
      @quotations = Quotation.order(:category)
    end

    if params[:keyword]
      @quotations = Quotation.where("quote like ?", "%#{params[:keyword]}%")
    end

    if params[:export_xml]
      xmlfile = current_favorites.to_xml
      send_data xmlfile, :filename => "quotes.xml", :type => "application/xml"
    end

    if params[:export_json]
      jsonfile = current_favorites.to_json
      send_data jsonfile, :filename => "quotes.json", :type => "application/json"
    end

    if params[:upload]
      # puts "================ UPLOADING DATA ==================="
      # puts params[:attachment].content_type
      file_data = params[:attachment]
      if file_data.respond_to?(:read)
        contents = file_data.read
        if params[:attachment].content_type == 'text/xml'
          hash = Hash.from_xml(contents)['objects']
        else
          hash = JSON.parse(contents)
        end
        Quotation.create(hash)
      elsif file_data.respond_to?(:path)
        contents = File.read(file_data.path)
      else
        logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
      end
    end
  end

  private

  def download
    send_data pdf,
              :filename => "abc.pdf",
              :type => "application/pdf"
  end

  def add_to_favorites
    @favorite = Quotation.find(params[:favorite])
    if current_favorites.all? { |fav| fav["id"].to_s != params[:favorite] }
      current_favorites << @favorite
    end
  end

  def remove_from_favorites
    session[:favorites] = session[:favorites].filter { |fav| fav["id"].to_s != params[:remove_favorite] }
  end

  def clear_favorites
    session[:favorites] = []
  end

  def quotation_params
    params.require(:quotation).permit(:author_name, :category, :quote)
  end
end
