class CommentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(content: params[:comment][:content],
                                     author: current_user.username)
    @comment.save

    redirect_to "/projects/#{@project.slug}"
  end

  def delete
    @delete_comment = Comment.find(params[:id]).destroy
    flash[:success] = "comment deleted!"
  end

end
