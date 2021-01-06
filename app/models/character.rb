class Character < ApplicationRecord
  
  has_many :pet_characters, dependent: :destroy
  has_many :pets, through: :genres
  
  enum name: {
    おとなしい: 1,
    さみしがり: 2,
    やんちゃ:   3,
    かしこい:   4,
    のんき:     5,
    おくびょう: 6,
    きまぐれ:   7,
    世話好き:   8
  }
  
end
