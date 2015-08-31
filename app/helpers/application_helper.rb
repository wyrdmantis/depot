module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag(:div, attributes, &block)
  end

  def localize_price(price)
    price = price * 0.89 if I18n.locale.to_s == 'es'
    number_to_currency(price)
  end
end
