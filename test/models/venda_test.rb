require 'test_helper'

class VendaTest < ActiveSupport::TestCase
  def setup
    @venda = Venda.new
    @venda.purchaser_name= "teste"
    @venda.item_price= "teste"
    @venda.purchase_count= "teste"
  end
  
  test "validacao purchaser name" do
    @venda.purchaser_name= nil
    assert_not @venda.save
    
    @venda.purchaser_name= "teste"
    assert @venda.save
  end
  
  test "validacao item price" do
    @venda.item_price= nil
    assert_not @venda.save
    
    @venda.item_price= "teste"
    assert @venda.save
  end
  
  test "validacao purchase count" do
    @venda.purchase_count= nil
    assert_not @venda.save
    
    @venda.purchase_count= "teste"
    assert @venda.save
  end
end
