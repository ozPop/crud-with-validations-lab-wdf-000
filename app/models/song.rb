class Song < ActiveRecord::Base
  after_initialize :add_released_default

  private

  def add_released_default
    self.released ||= false
  end

end
