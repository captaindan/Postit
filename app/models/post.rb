class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :votes, as: :voteable

	validates :title, presence: true
	validates :url, presence: true
	validates :description, presence: true

	after_validation :generate_slug

	#def voted?(obj)
    #self.votes.where("user_id = ?", current_user.id).size > 0
  #end

	def total_votes
		self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end

 def to_param
    self.slug
  end
 
  def generate_slug
    str = to_slug(self.title)
    count = 2
    obj = Post.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = Post.where(slug: str).first
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