#peer-router-peer

# creating namespaces 

sudo ip netns add peer1
sudo ip netns add router
sudo ip netns add peer2

# showing the created namespaces

ip link list

#assigning the interface to the namespaces

sudo ip link add veth0 type veth peer name veth1
sudo ip link set veth0 netns peer1
sudo ip link set veth1 netns router


sudo ip link add veth2 type veth peer name veth3
sudo ip link set veth2 netns peer2
sudo ip link set veth3 netns router

#showing the assigning interfaces
sudo ip netns exec router ip link list

"""
Notes-
1) ip netns exec - running different commands inside perticular namespaces
2) router - namespaces in which command runs
3) ip link list - showing the namespaces 
"""

# configuring the interfaces in network namespaces

sudo ip netns exec peer1 ip addr add 10.0.0.2/24 dev veth0
sudo ip netns exec router  ip addr add 10.0.0.1/24 dev veth1

sudo ip netns exec peer2 ip addr add 10.0.1.2/24 dev veth2
sudo ip netns exec router ip addr add 10.0.1.1/24 dev veth3

# bring the interfaces up

sudo ip netns exec peer1 ip link set dev veth0 up
sudo ip netns exec router ip link set dev veth1 up

sudo ip netns exec peer2 ip link set dev veth2 up
sudo ip netns exec router ip link set dev veth3 up

sudo ip netns exec router sysctl -w net.ipv4.conf.all.forwarding=1

sudo ip netns exec peer1 ip route add default via 10.0.0.1
sudo ip netns exec peer2 ip route add default via 10.0.1.1

# deleting the namespaces

sudo ip netns delete peer1
sudo ip netns delete peer2
sudo ip netns delete router
