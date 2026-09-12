include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pushbot
PKG_VERSION:=3.62
PKG_RELEASE:=2

PKG_MAINTAINER:=tty228 <tty228@yeah.net>  zzsj0928 MasterOfStar

LUCI_TITLE:=LuCI support for Pushbot
LUCI_PKGARCH:=all

# OpenWrt 25.10 兼容说明：
#   - 流量统计后端由 wrtbwmon 更换为 nlbwmon，脚本通过 `nlbw -c json` 取数，
#     并用 /usr/bin/jq 解析结果，因此必须新增 +jq 依赖
#   - 保留原 curl / iputils-arping；新增 wget-ssl 以确保 HTTPS 下载 OUI 可用
#   - ipset / iptables 用于脚本内的 IP 黑名单功能
LUCI_DEPENDS:=+curl +jq +nlbwmon +iputils-arping +wget-ssl +ipset +iptables

define Package/$(PKG_NAME)/conffiles
/etc/config/pushbot
/usr/bin/pushbot/api/diy.json
/usr/bin/pushbot/api/ipv4.list
/usr/bin/pushbot/api/ipv6.list
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
