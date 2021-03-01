class DaiaryComment < ApplicationRecord
    
  belongs_to :pet
  belongs_to :diary
    
end
