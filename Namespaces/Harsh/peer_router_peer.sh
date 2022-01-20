#peer-router-peer



sudo ip netns add peerFirst
sudo ip netns add router
sudo ip netns add peerSecond

ip link list

sudo ip link add veth0 type veth peer name veth1
sudo ip link set veth0 netns peerFirst
sudo ip link set veth1 netns router


sudo ip link add veth2 type veth peer name veth3
sudo ip link set veth2 netns peerSecond
sudo ip link set veth3 netns router

sudo ip netns exec router ip link list


sudo ip netns exec peerFirst ip addr add 10.0.0.2/24 dev veth0
sudo ip netns exec router  ip addr add 10.0.0.1/24 dev veth1

sudo ip netns exec peerSecond ip addr add 10.0.1.2/24 dev veth2
sudo ip netns exec router ip addr add 10.0.1.1/24 dev veth3

sudo ip netns exec peerFirst ip link set dev veth0 up
sudo ip netns exec router ip link set dev veth1 up

sudo ip netns exec peerSecond ip link set dev veth2 up
sudo ip netns exec router ip link set dev veth3 up

sudo ip netns exec router sysctl -w net.ipv4.conf.all.forwarding=1

sudo ip netns exec peerFirst ip route add default via 10.0.0.1
sudo ip netns exec peerSecond ip route add default via 10.0.1.1

sudo ip netns delete peerFirst
sudo ip netns delete peerSecond
sudo ip netns delete router
