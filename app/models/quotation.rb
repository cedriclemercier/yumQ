class Quotation < ApplicationRecord
    validates_presence_of :category, :quote, :author_name
    # attr_accessor :new_category
end
