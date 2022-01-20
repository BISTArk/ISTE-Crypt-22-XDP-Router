#!/bin/sh

sudo ip netns add server1
sudo ip netns add client1

sudo ip link add v-net-0 type bridge
sudo ip link set dev v-net-0 up
sudo ip link add veth0 type veth peer name veth0-br
sudo ip link add veth1 type veth peer name veth1-br

sudo ip link set veth0 netns server1
sudo ip link set veth0-br master v-net-0
sudo ip link set veth1 netns client1
sudo ip link set veth1-br master v-net-0

sudo ip netns exec server1 ip addr add 192.168.15.1 dev veth0
sudo ip netns exec client1 ip addr add 192.168.15.2 dev veth1

sudo ip netns exec server1 ip link set dev veth0 up
sudo ip netns exec client1 ip link set dev veth1 up









