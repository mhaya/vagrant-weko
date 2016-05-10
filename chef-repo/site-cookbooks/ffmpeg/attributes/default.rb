default[:ffmpeg][:pkg_name] = "ffmpeg"

case node[:platform]
when 'centos'
  if node[:platform_version].to_i == 7
default[:nux_dextop][:rpm] = "nux-dextop-release-0-5.el7.nux.noarch.rpm"
default[:nux_dextop][:rpm_url] = "http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm"
default[:nux_dextop][:rpm_checksum] = "9e55c1c38a6cb86a58daa01abbc5d8a01162cc05a7ec6988179c05a1d932922b"
  end
end









