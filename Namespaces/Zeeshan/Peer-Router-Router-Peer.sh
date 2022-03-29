ip netns add user1
ip netns add router1
ip netns add user2
ip netns add router2

ip link add veth0 type veth peer name veth1
ip link add veth2 type veth peer name veth3
ip link add veth4 type veth peer name veth5

ip link set veth0 netns user1
ip link set veth1 netns router1

ip link set veth2 netns router1
ip link set veth3 netns router2

ip link set veth4 netns user2
ip link set veth5 netns router2

ip netns exec user1 ip addr add 10.0.0.1/24 dev veth0 
ip netns exec router1 ip addr add 10.0.0.2/24 dev veth1 

ip netns exec router1 ip addr add 10.0.1.1/24 dev veth2 
ip netns exec router2 ip addr add 10.0.1.2/24 dev veth3 

ip netns exec user2 ip addr add 10.1.1.2/24 dev veth4
ip netns exec router2 ip addr add 10.1.1.1/24 dev veth5 

ip netns exec user1 ip link set dev veth0 up
ip netns exec router1 ip link set dev veth1 up

ip netns exec router1 ip link set dev veth2 up
ip netns exec router2 ip link set dev veth3 up

ip netns exec user2 ip link set dev veth4 up
ip netns exec router2 ip link set dev veth5 up

ip netns exec router1 sysctl net.ipv4.conf.all_forwarding=1
ip netns exec router2 sysctl net.ipv4.conf.all_forwarding=1

ip netns exec user1 ip route add default via 10.0.0.2
ip netns exec router1 ip route add default via 10.0.1.2
ip netns exec router2 ip route add default via 10.0.1.1
ip netns exec user2 ip route add default via 10.1.1.1

#To ping
ip netns exec client1 ping 10.1.1.2 -c 4
ip netns exec client2 ping 10.0.0.1 -c 4

