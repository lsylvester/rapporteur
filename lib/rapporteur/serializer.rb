module Rapporteur
  class Serializer < ActiveModel::Serializer
    self.root = false

    attributes :revision,
               :time

    def time
      object.time.utc
    end
  end
end