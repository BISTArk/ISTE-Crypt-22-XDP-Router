ip netns add user1
ip netns add user2
ip netns add router

ip link add veth0 type veth peer name veth1
ip link set veth0 netns user1
ip link set veth1 netns router

ip link add veth2 type veth peer name veth3
ip link set veth2 netns user2
ip link set veth3 netns router

ip netns exec user1 ip addr add 10.0.0.1/24 dev veth0
ip netns exec router  ip addr add 10.0.0.2/24 dev veth1

ip netns exec user2 ip addr add 10.0.1.1/24 dev veth2
ip netns exec router ip addr add 10.0.1.2/24 dev veth3

ip netns exec user1 ip link set dev veth0 up

ip netns exec router ip link set dev veth1 up

ip netns exec user2 ip link set dev veth2 up

ip netns exec router ip link set dev veth3 up

ip netns exec router sysctl -w net.ipv4.conf.all_forwarding=1

ip netns exec user1 ip route add default via 10.0.0.2
ip netns exec user2 ip route add default via 10.0.1.2

##To ping
ip netns exec user1 ping 10.0.1.1
ip netns exec user2 ping 10.0.0.1

