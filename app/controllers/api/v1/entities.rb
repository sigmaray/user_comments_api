module Api
  module V1
    module Entities
      class Comment < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "Comment ID" }
        expose :content, documentation: { type: "String", desc: "Comment content" }
      end

      class User < Grape::Entity
        expose :id, documentation: { type: "Integer", desc: "User ID" }
        expose :username, documentation: { type: "String", desc: "Username" }
        expose :email, documentation: { type: "String", desc: "Email" }
      end

      class UsersResponse < Grape::Entity
        expose :page, documentation: { type: "Integer", desc: "Page number" }
        expose :per_page, documentation: { type: "Integer", desc: "Number of entries per page" }
        expose :users, using: Entities::User, documentation: { type: "Array", desc: "List of users" }
      end

      class CommentsResponse < Grape::Entity
        expose :page, documentation: { type: "Integer", desc: "Page number" }
        expose :per_page, documentation: { type: "Integer", desc: "Number of items per page" }
        expose :user_id, documentation: { type: "Integer", desc: "User ID" }
        expose :comments, using: Entities::Comment, documentation: { type: "Array", desc: "List of comments" }
      end
    end
  end
end
