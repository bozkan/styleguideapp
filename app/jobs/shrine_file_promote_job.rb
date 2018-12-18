class ShrineFilePromoteJob < ApplicationJob
  queue_as :high

  def perform(data)
    Shrine::Attacher.promote(data)
  end
end
