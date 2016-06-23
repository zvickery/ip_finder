#!/usr/bin/env ruby

require 'logger'
require 'socket'

port = 5151

logfile = "#{File.expand_path(File.dirname(__FILE__))}/ip.log"
logger = Logger.new(logfile)
logger.level = Logger::INFO

server = TCPServer.new port
loop do
  Thread.start(server.accept) do |client|
    remote = client.addr[2]
    client.recvfrom(512)
    client.puts "#{remote}\n"
    logger.info("Client: #{remote}")
    client.close
  end
end
