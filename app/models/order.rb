# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  aasm_state :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items

  include AASM

  aasm create_scopes: false do
    state :new, initial: true
    state :finalized
    state :ordered
    state :delivered

    event :finalize do
      transitions from: :new, to: :finalized
    end

    event :order do
      transitions from: :finalized, to: :ordered
    end

    event :deliver do
      transitions from: :ordered, to: :delivered
    end
  end

  def as_json(options)
    super(options.merge(include: { items: {
                                   except: [:created_at, :updated_at]} }))
  end
end
