class Article < ApplicationRecord
    #include DeviseTokenAuth::Concerns::User
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, presence: true, length: { minimum: 5 }
    validates :text, presence: true
    
    def to_array
        {
            "id" => self.id,
            "title" => self.title,
            "text" => self.text,
            "user_id" => self.user.id,
            "comments" => self.comments 
        }
    end
end
