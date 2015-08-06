#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new(:hostname => "localhost")
conn.start

ch = conn.create_channel
x = ch.fanout("logs")
q = ch.queue("", :exclusive => true)

q.bind(x)

begin
	puts "[*] Waiting for messages in queue #{q.name} of exchange #{x.name}. To exit press CTRL+C"
	q.subscribe(:block => true) do |delivery_info, properties, body|
		puts " [x] #{body}"
	end
rescue Interrupt => _
	ch.close
	conn.close
end
