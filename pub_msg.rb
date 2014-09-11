require "xmpp4r"
require "xmpp4r/pubsub"
require "xmpp4r/pubsub/helper/servicehelper.rb"
require "xmpp4r/pubsub/helper/nodebrowser.rb"
require "xmpp4r/pubsub/helper/nodehelper.rb"

include Jabber
Jabber::debug = true

domain = 'eric.local' #需替换
service = "pubsub.#{domain}"
jid = "pub@#{domain}/laptop"

password = 'pub'
node = "/home/#{domain}/test1"

client = Client.new(JID.new(jid))
client.connect
client.auth(password)
client.send(Jabber::Presence.new.set_type(:available))

pubsub = PubSub::ServiceHelper.new(client, service)
item = Jabber::PubSub::Item.new
xml = REXML::Element.new("entry")
xml.text = "<data type='msg_text'>hello</data>"
item.add(xml);
pubsub.publish_item_to(node, item)
