class CartItemsController < InheritedResources::Base

  before_action :set_cart
  before_action :set_cart_item, only: %i[ destroy ]

  def create
    @menu = Menu.find(params[:menu_id])
    item = CartItem.find_or_create_by(:cart_id => @cart.id, :menu_id => @menu.id)
    item.increment! :quantity
    flash[:notice] = "Added #{@menu.name} to cart."
  end

  def destroy
    @menu.delete
    respond_to do |format|
        format.html { redirect_to cart_index_path, notice: "Table was successfully destroyed." }
        format.json { head :no_content }
      end
  end

  private

    # def cart_item_params
    #   params.require(:cart_item).permit(:cart_id, :menu_id, :quantity)
    # end

  def set_cart_item
    @menu = CartItem.find(params[:id])
  end

end
