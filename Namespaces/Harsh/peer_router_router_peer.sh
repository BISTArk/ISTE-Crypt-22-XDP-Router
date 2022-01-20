sudo ip netns add peer1st
sudo ip netns add router1
sudo ip netns add router2
sudo ip netns add peer2nd

sudo ip link add veth0 type veth peer name veth1
sudo ip link add veth2 type veth peer name veth3
sudo ip link add veth4 type veth peer name veth5

sudo ip link set veth0 netns peer1st
sudo ip link set veth1 netns router1

sudo ip link set veth2 netns router1
sudo ip link set veth3 netns router2

sudo ip link set veth4 netns peer2nd
sudo ip link set veth5 netns router2

sudo ip netns exec peer1st ip addr add 10.0.0.1/24 dev veth0 
sudo ip netns exec router1 ip addr add 10.0.0.2/24 dev veth1 

sudo ip netns exec router1 ip addr add 10.0.1.1/24 dev veth2 
sudo ip netns exec router2 ip addr add 10.0.1.2/24 dev veth3 

sudo ip netns exec peer2nd ip addr add 10.1.1.2/24 dev veth4
sudo ip netns exec router2 ip addr add 10.1.1.1/24 dev veth5 

sudo ip netns exec peer1st ip link set dev veth0 up
sudo ip netns exec router1 ip link set dev veth1 up

sudo ip netns exec router1 ip link set dev veth2 up
sudo ip netns exec router2 ip link set dev veth3 up

sudo ip netns exec peer2nd ip link set dev veth4 up
sudo ip netns exec router2 ip link set dev veth5 up

sudo ip netns exec router1 sysctl -w net.ipv4.conf.all.forwarding=1
sudo ip netns exec router2 sysctl -w net.ipv4.conf.all.forwarding=1

sudo ip netns exec peer1st ip route add default via 10.0.0.2
sudo ip netns exec router1 ip route add default via 10.0.1.2
sudo ip netns exec router2 ip route add default via 10.0.1.1
sudo ip netns exec peer2nd ip route add default via 10.1.1.1

echo "Ping 10.1.1.2 from peer1st...."
sudo ip netns exec peer1st ping 10.1.1.2 -c 6
echo "Ping 10.0.0.1 from peer2nd...."
sudo ip netns exec peer2nd ping 10.0.0.1 -c 6

sudo ip netns delete peer1st
sudo ip netns delete peer2nd
sudo ip netns delete router1
sudo ip netns delete router2