#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

msg = "Hello World!"

conn = Bunny.new(:hostname => "localhost")
conn.start

ch = conn.create_channel
x = ch.fanout("logs")

x.publish(msg)
puts "[x] Sent #{msg}"

conn.close

