require 'will_paginate'

class CoursesController < ApplicationController
  def index
    @courses=Course.search(params[:search]).paginate(:page=>params[:page], :per_page=>5)
  end

  def show
    @course=Course.find(params[:id])
  end

  def new
    @course=Course.new
  end

  def create
    @course=Course.new(params[:course])
    if @course.save
      Usermailer.contact(@course).deliver
      redirect_to courses_path, :message=>"saved"
    else
      render 'new'
    end
  end

  def edit
    @course=Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      redirect_to courses_path, :message=>"updated"
    else 
      render "edit"
    end
  end

  def destroy
    @course=Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.js
    end
#    redirect_to courses_path, :notice=>"deleted"
  end  
end
