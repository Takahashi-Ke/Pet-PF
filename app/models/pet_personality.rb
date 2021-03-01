class PetPersonality < ApplicationRecord

  belongs_to :pet

  validates :personality, presence: true

  enum personality: {
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
