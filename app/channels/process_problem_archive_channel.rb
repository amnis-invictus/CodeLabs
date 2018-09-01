class ProcessProblemArchiveChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ProcessProblemArchive:#{ params[:id] }"
  end
end
