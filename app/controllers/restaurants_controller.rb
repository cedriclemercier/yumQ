class RestaurantsController < InheritedResources::Base

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :user_id)
    end

end
