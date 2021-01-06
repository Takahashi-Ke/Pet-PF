class PetCharacter < ApplicationRecord
  
  belongs_to :pet
  belongs_to :character
  
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
