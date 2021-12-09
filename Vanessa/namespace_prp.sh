# Peer-Router-Peer Topology

# creating the node namespaces
echo "Creating the node namespaces and veth pairs..."
sudo ip netns add namespace1
sudo ip netns add namespace2

# veth pairs for each of the namespaces
sudo ip link add veth1 type veth peer name rt-veth1
sudo ip link add veth2 type veth peer name rt-veth2

# setting interfaces for namespaces
sudo ip link set veth1 netns namespace1
sudo ip link set veth2 netns namespace2

# creating router, setting link between namespace and router
echo "Creating the router namespace and veth pairs..."
sudo ip netns add Router1
sudo ip link set rt-veth1 netns Router1
sudo ip link set rt-veth2 netns Router1

echo "Setting ip addresses for interface in namespaces and routers..."

# setting ip addresses for interface in namespace1
sudo ip netns exec namespace1 ip addr add 1.1.1.2/24 dev veth1
sudo ip netns exec namespace1 ip link set veth1 up
sudo ip netns exec namespace1 ip link set lo up

# setting ip addresses for interface in namespace2
sudo ip netns exec namespace2 ip addr add 2.2.2.2/24 dev veth2
sudo ip netns exec namespace2 ip link set veth2 up
sudo ip netns exec namespace2 ip link set lo up

# setting ip addresses for interface in Router
sudo ip netns exec Router1 ip addr add 1.1.1.1/24 dev rt-veth1
sudo ip netns exec Router1 ip addr add 2.2.2.1/24 dev rt-veth2
sudo ip netns exec Router1 ip link set rt-veth1 up
sudo ip netns exec Router1 ip link set rt-veth2 up
sudo ip netns exec Router1 ip link set lo up

echo "Enabling forwarding in namespaces and routers..."
# forwarding packets in namespace1 to Router
sudo ip netns exec namespace1 ip route add default via 1.1.1.1
# forwarding packets in namespace2 to Router
sudo ip netns exec namespace2 ip route add default via 2.2.2.1

# ping namespace2 from namespace1
echo "Pinging namespace2 (2.2.2.2) from namespace1(1.1.1.2)"
sudo ip netns exec namespace1 ping 2.2.2.2 -c 2

# ping namespace1 from namespace2
echo "Pinging namespace1 (1.1.1.2) from namespace2(2.2.2.2)"
sudo ip netns exec namespace2 ping 1.1.1.2 -c 2

# deleting namespaces 
echo "Deleting namespaces..."
sudo ip netns delete namespace1
sudo ip netns delete namespace2
sudo ip netns delete Router1


