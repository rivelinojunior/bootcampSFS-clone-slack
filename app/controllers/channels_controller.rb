class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[destroy show]

  def create
  end

  def destroy
    authorize! :destroy, @channel
    @channel.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def show
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
