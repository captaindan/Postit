class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, through: :post_categories

	validates :name, presence: :true

	after_validation :generate_slug

	def to_param
    self.slug
  end
 
  def generate_slug
    str = to_slug(self.name)
    count = 2
    obj = Category.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = Category.where(slug: str).first
      count += 1
    end
    self.slug = str.downcase
  end
 
  def to_slug(name)
    #strip the string
    ret = name.strip
 
    #blow away apostrophes
    ret.gsub! /['`]/,""
 
    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "
 
    #replace all non alphanumeric with dash
     ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
 
     #convert double dashes to single
     ret.gsub! /-+/,"-"
 
     #strip off leading/trailing dash
     ret.gsub! /\A[-\.]+|[-\.]+\z/,""
 
     ret
  end

end