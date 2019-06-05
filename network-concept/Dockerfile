FROM alpine:latest
MAINTAINER Erik Thomsen 

RUN apk add openvpn curl
ADD route_all_traffic.ovpn /etc/openvpn/
ADD split_tunnel.ovpn /etc/openvpn/