class CartsController < InheritedResources::Base

  before_action :set_cart

  def index
    @cart_contents = @cart.cart_items.all
  end

  private

    def cart_params
      params.require(:cart).permit(:total, :user_id)
    end

end
