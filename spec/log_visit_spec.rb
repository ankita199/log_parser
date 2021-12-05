# frozen_string_literal: true

require './lib/log_visit'
describe LogVisit do
  let(:log_file_path) { "#{File.dirname(File.absolute_path(__FILE__))}/data" }
  subject { described_class.new("#{log_file_path}/test.log") }
  it { should respond_to :file_path }

  describe '#initialize' do
    it 'should contain a filepath' do
      expect(subject.file_path).to eq("#{log_file_path}/test.log")
    end

    it 'should contain a blank array of logs' do
      expect(subject.logs).to match_array([])
    end
  end

  describe '#parse_file' do
    it 'should parse file content' do
      subject.parse_file
      expect(subject.logs.keys).to eq(['/help_page', '/contact'])
      expect(subject.logs.count).to eq(2)
    end

    it 'should parse file content of empty file' do
      tmp = described_class.new("#{log_file_path}/empty.log")
      tmp.parse_file
      expect(tmp.logs).to match_array([])
    end

    it 'should return nil if file does not exists' do
      tmp = described_class.new("#{log_file_path}/notexists.log")
      expect(tmp.parse_file).to eq('File does not exists')
    end
  end

  describe '#sort_by' do
    it 'should sort logs by visits' do
      subject.parse_file
      expect(subject.sort_by('visits')).to eq([['/help_page', 6], ['/contact', 4]])
    end

    it 'should sort logs by unique_visits' do
      subject.parse_file
      expect(subject.sort_by('unique_visits')).to eq([['/help_page', 5], ['/contact', 3]])
    end

    it 'should return an empty array if condition is invalid' do
      subject.parse_file
      expect(subject.sort_by('anything')).to match_array([])
    end
  end
end
