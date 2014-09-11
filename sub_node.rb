require "xmpp4r"
require "xmpp4r/pubsub"
require "xmpp4r/pubsub/helper/servicehelper.rb"
require "xmpp4r/pubsub/helper/nodebrowser.rb"
require "xmpp4r/pubsub/helper/nodehelper.rb"

include Jabber
Jabber::debug = true

domain = 'eric.local' #需替换
service = "pubsub.#{domain}"
jid = "james@#{domain}/laptop"

password = '123456'
node = "/home/#{domain}/bulletin"

client = Client.new(JID.new(jid))
client.connect
client.auth(password)
client.send(Jabber::Presence.new.set_type(:available))

# subscribe to the node
pubsub = PubSub::ServiceHelper.new(client, service)
pubsub.subscribe_to(node)
subscriptions = pubsub.get_subscriptions_from_all_nodes()
puts "subscriptions: #{subscriptions}\n\n"
puts "events:\n"

# set callback for new events

pubsub.add_event_callback do |event|
  event.payload.each do |e|
    puts e,"----\n"
  end
end
# infinite loop
loop do
  sleep 1
end
