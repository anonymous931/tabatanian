class TimerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "timer_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @current_worker = ActionCable.server.connections.length
    ActionCable.server.broadcast('timer_channel', { content: @current_worker })
  end
end
