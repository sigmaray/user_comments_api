module Api
  module V1
    class Users < Grape::API
      desc "Get a list of users and their comments"
      resource :users do
        desc "Get a list of users and their comments",
        success: {
          code: 200,
          message: "Success",
          model: Entities::UsersResponse
        },
        failure: [
               { code: 500, message: "Internal Server Error" } ]
        params do
          optional :page, type: Integer, default: 1, desc: "Page number"
          optional :per_page, type: Integer, default: 100, desc: "Number of entries per page"
        end
        get do
          users = User.page(params[:page]).per(params[:per_page])
          present({
            page: params[:page],
            per_page: params[:per_page],
            users: users.map do |user|
              {
                id: user.id,
                username: user.username,
                email: user.email
              }
            end
          }, with: Entities::UsersResponse)
        end

        desc "Get user comments with pagination",
          success: { code: 200, message: "Success", model: Entities::CommentResponse },
          failure: [
               { code: 404, message: "User Not Found" },
               { code: 500, message: "Internal Server Error" }
             ]
        params do
          requires :user_id, type: Integer, desc: "User ID"
          optional :page, type: Integer, default: 1, desc: "Page number"
          optional :per_page, type: Integer, default: 100, desc: "Number of items per page"
        end
        get "/:user_id/comments" do
          user = User.find(params[:user_id])
          comments = user.comments.order(created_at: :desc).page(params[:page]).per(params[:per_page])
          present({
            page: params[:page],
            per_page: params[:per_page],
            user_id: params[:user_id],
            comments: comments.map do |comment|
              {
                id: comment.id,
                content: comment.content
              }
            end
            }, with: Entities::CommentResponse)
        end
      end
    end
  end
end
