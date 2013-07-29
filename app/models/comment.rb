class Comment < ActiveRecord::Base
	#creator modification, might need to modify controller commands
	#and then can remove belongs_to :user
	#belongs_to :creator, class_name: 'User', foreign_key: :user_id
	belongs_to :post
	belongs_to :user
	has_many :votes, as: :voteable

	validates :body, presence: true

	def total_votes
		self.votes.where(vote: true).size - self.votes.where(vote: false).size
	end

end