class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_many :favorites, dependent: :destroy

  has_many :comments, dependent: :destroy

  def favorite_by?(user)
    Favorite.exists?(user_id: user.id, book_id: self.id)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end
end  


