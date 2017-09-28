class Comment < ApplicationRecord
    #include DeviseTokenAuth::Concerns::User
    belongs_to :article
    belongs_to :user
end
