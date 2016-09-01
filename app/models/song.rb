class Song < ActiveRecord::Base
  after_initialize :add_released_default

  # Must not be blank
  validates :title, presence: true
  # Cannot be repeated by the same artist in the same year
  validate :title_exists_this_year?
  # Released must be true or false
  validates :released, inclusion: { in: [true, false] }
  # Optional if released is false
  validates :release_year, presence: true, if: :released?
  # Must be less than or equal to current year
  validate :future_date?
  # Must not be blank
  validates :artist_name, presence: true

  private

  def add_released_default
    self.released ||= false
  end

  def title_exists_this_year?
    song = Song.all.find_by(title: self.title)
    if song.blank? == false && song.release_year == self.release_year
      errors.add(:title, "Can't use title twice in same year")
    end
  end

  def released?
    self.released
  end

  def future_date?
    if self.release_year
      errors.add(:release_year, "Invalid Year Input") unless self.release_year <= Time.now.year
    end
  end

end
