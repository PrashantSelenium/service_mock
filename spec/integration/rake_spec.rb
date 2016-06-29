require 'spec_helper'
require 'net/http'
require 'service_mock/rake/start_server_task'
require 'service_mock/rake/stop_server_task'

describe 'Rake Task test' do

  SERVER_VERSION = 'standalone-2.1.1-beta'
  let(:mock) { ServiceMock::Server.new(SERVER_VERSION) }
  let(:start_server) { ::ServiceMock::Rake::StartServerTask }
  let(:stop_server) { ::ServiceMock::Rake::StopServerTask}

  it 'starts the server process' do
    rake_task = start_server.new(:start_server, SERVER_VERSION)
    ::Rake::Task[:start_server].execute
    sleep 1
    expect(rake_task.server.process.alive?).to be true
    mock.stop
  end

  it 'stops the server process' do
    rake_task = stop_server.new(:stop_server, SERVER_VERSION)
    mock.start
    sleep 1
    expect(mock.process.alive?).to be true
    ::Rake::Task[:stop_server].execute
    sleep 1
    expect(rake_task.server.process).to be_nil
  end
end
