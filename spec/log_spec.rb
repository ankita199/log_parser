# frozen_string_literal: true

require './lib/log'
describe Log do
  subject { described_class.new('/home', '126.318.035.038') }
  it { should respond_to :url }
  it { should respond_to :ip }

  describe '#initialize' do
    it 'should contain a url ' do
      expect(subject.url).to eq('/home')
    end

    it 'should contain an ip' do
      expect(subject.ip).to eq('126.318.035.038')
    end
  end
end
