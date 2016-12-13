require 'spec_helper'

RSpec.describe Profile do
  let(:shaka) { create(:shaka) }
  let(:profile) { shaka.profile }
end
