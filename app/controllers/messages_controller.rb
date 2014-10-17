class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json

  def index
    @messages = Message.all
    # respond_with(@messages)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    # respond_with(@message)
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    flash[:notice] = 'Message was successfully created.' if @message.save
    respond_with(@message)
  end

  def update
    flash[:notice] = 'Message was successfully updated.' if @message.update(message_params)
    respond_with(@message)
  end

  def destroy
    @message.destroy
    respond_with(@message)
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
       params.require(:message).permit(:text, :voice_link)
    end
end
