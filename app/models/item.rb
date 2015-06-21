# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  validates :name, presence: true, length: { in: 2..20 }
  validates :price, numericality: { greater_than: 0, less_than: 10000 }

  has_and_belongs_to_many :orders

  def as_json(options)
    super({except: [:created_at, :updated_at]}.merge(options))
  end
end
