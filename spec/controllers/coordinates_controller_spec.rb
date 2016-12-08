require 'spec_helper'

RSpec.describe CoordinatesController, type: :controller do

  describe "update action for coordinate" do
    before do
      patch :update, params: { id: coordinate.id }
    end

  end

end
