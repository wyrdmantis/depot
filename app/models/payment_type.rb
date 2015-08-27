class PaymentType < ActiveRecord::Base
  def self.allowed_methods
    all.collect { |type| type.name }
  end
end
