# Peer-Router-Router-Peer Topology

# creating the node namespaces
echo "Creating the node namespaces and veth pairs..."
sudo ip netns add namespace1
sudo ip netns add namespace2

# veth pairs for each of the namespaces
sudo ip link add veth1 type veth peer name rt1-veth1
sudo ip link add veth2 type veth peer name rt2-veth2

# setting interfaces for namespaces
sudo ip link set veth1 netns namespace1
sudo ip link set veth2 netns namespace2

# creating routers, setting link between namespace and routers
echo "Creating the router namespaces and veth pairs..."
sudo ip netns add Router1
sudo ip netns add Router2
sudo ip link set rt1-veth1 netns Router1
sudo ip link set rt2-veth2 netns Router2

# # creating veth pair for Routers

sudo ip link add veth3 type veth peer name veth4
sudo ip link set veth3 netns Router1
sudo ip link set veth4 netns Router2

echo "Setting ip addresses for interface in namespaces and routers..."

# setting ip addresses for interface in namespace1
sudo ip netns exec namespace1 ip addr add 10.0.0.2/24 dev veth1
sudo ip netns exec namespace1 ip link set veth1 up
sudo ip netns exec namespace1 ip link set lo up


# setting ip addresses for interface in namespace2
sudo ip netns exec namespace2 ip addr add 10.1.1.2/24 dev veth2
sudo ip netns exec namespace2 ip link set veth2 up
sudo ip netns exec namespace2 ip link set lo up

# setting ip addresses for interfaces in Router1
sudo ip netns exec Router1 ip addr add 10.0.0.1/24 dev rt1-veth1
sudo ip netns exec Router1 ip addr add 10.0.1.1/24 dev veth3
sudo ip netns exec Router1 ip link set rt1-veth1 up
sudo ip netns exec Router1 ip link set veth3 up
sudo ip netns exec Router1 ip link set lo up

# setting ip addresses for interfaces in Router2
sudo ip netns exec Router2 ip addr add 10.1.1.1/24 dev rt2-veth2
sudo ip netns exec Router2 ip addr add 10.0.1.2/24 dev veth4
sudo ip netns exec Router2 ip link set rt2-veth2 up
sudo ip netns exec Router2 ip link set veth4 up
sudo ip netns exec Router2 ip link set lo up

echo "Enabling forwarding in namespaces and routers..."
# forwarding packets in namespace1 to Router1
sudo ip netns exec namespace1 ip route add default via 10.0.0.1

# forwarding packets in namespace2 to router2
sudo ip netns exec namespace2 ip route add default via 10.1.1.1

# forwarding packets in Router1 to Router2
sudo ip netns exec Router1 ip route add default via 10.0.1.2

# forwarding packets in Router2 to Router1
sudo ip netns exec Router2 ip route add default via 10.0.1.1

# checking if IPv4 forwarding is enabled
echo "Checking if IPv4 forwarding is enabled..."
cat /proc/sys/net/ipv4/ip_forward

# ping namespace2 from namespace1
echo "Pinging namespace2 (2.2.2.2) from namespace1(1.1.1.2)"
sudo ip netns exec namespace1 ping 10.1.1.2 -c 2

# ping namespace1 from namespace2
echo "Pinging namespace1 (1.1.1.2) from namespace2(2.2.2.2)"
sudo ip netns exec namespace2 ping 10.0.0.2 -c 2

# deleting namespaces 
echo "Deleting namespaces..."
sudo ip netns delete namespace1
sudo ip netns delete namespace2
sudo ip netns delete Router1
sudo ip netns delete Router2
