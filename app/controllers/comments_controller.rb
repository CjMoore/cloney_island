class CommentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(content: params[:comment][:content],
                                     author: current_user.username)
    @comment.save

    redirect_to "/projects/#{@project.slug}"
  end

  def destroy
    @delete_comment = Comment.find(params[:id]).destroy
    flash[:success] = "comment deleted!"
    redirect_to request.referer
  end
end
