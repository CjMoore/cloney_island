class CommentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(comment_params)
    @comment.author = current_user.username
    if @comment.save
      flash[:notice] = "You have submitted a comment"
      redirect_to "/projects/#{@project.slug}"
    else
      flash[:danger] = "You cannot submit a blank comment."
      redirect_to request.referer
    end
  end

  def destroy
    @delete_comment = Comment.find(params[:id]).destroy
    flash[:success] = "comment deleted!"
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
