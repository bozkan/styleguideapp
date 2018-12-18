class ShrineFileDeleteJob < ApplicationJob
  queue_as :high

  def perform(data)
    Shrine::Attacher.delete(data)
  end
end
