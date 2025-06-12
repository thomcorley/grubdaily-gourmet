class DigestedReadTagging < ApplicationRecord
  belongs_to :digested_read
  belongs_to :tag
end
