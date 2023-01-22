class CommentsController < ApplicationController
    before_action :set_lesson, only: %i[ create destroy ]

    def create
        @comment = Comment.new(comment_params)
        @comment.lesson_id = @lesson.id
        @comment.user = current_user

        if @comment.save
            redirect_to course_lesson_path(@course, @lesson), notice: 'Lesson was successfully created.'
        else  
            render 'lessons/comments/new'
        end  
    end

    def destroy
        @comment = Comment.find(params[:id])
        authorize @comment
        @comment.destroy
        redirect_to course_lesson_path(@course, @lesson), notice: 'Comment was successfully destroyed.'
      end
  
    private
    
    def comment_params
        params.require(:comment).permit(:content)
    end

    def set_lesson 
        @course = Course.friendly.find(params[:course_id])
        @lesson = Lesson.friendly.find(params[:lesson_id])
    end
  end
