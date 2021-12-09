# creating namespaces....
sudo ip netns add p1
sudo ip netns add router
sudo ip netns add p2

# creating veth pairs.... 
sudo ip netns exec p1 ip link add veth0 type veth peer name veth1
sudo ip netns exec p1 ip link set veth1 netns router

sudo ip netns exec p2 ip link add veth3 type veth peer name veth2
sudo ip netns exec p2 ip link set veth2 netns router

sudo ip netns exec p1 ip addr add 10.0.0.2/24 dev veth0
sudo ip netns exec router ip addr add 10.0.0.1/24 dev veth1

sudo ip netns exec p2 ip addr add 10.0.1.2/24 dev veth3
sudo ip netns exec router ip addr add 10.0.1.1/24 dev veth2

sudo ip netns exec p1 ip link set dev veth0 up
sudo ip netns exec router ip link set dev veth1 up
sudo ip netns exec p2 ip link set dev veth3 up
sudo ip netns exec router ip link set dev veth2 up
sudo ip netns exec p1 ip link set dev lo up
sudo ip netns exec p2 ip link set dev lo up

sudo ip netns exec router sysctl -w net.ipv4.conf.all.forwarding=1

# adding routes....
sudo ip netns exec p1 ip route add default via 10.0.0.1
sudo ip netns exec p2 ip route add default via 10.0.1.1

# [p1] (veth0) <----> (veth1) [router] (veth2) <----> (veth3) [p2]
