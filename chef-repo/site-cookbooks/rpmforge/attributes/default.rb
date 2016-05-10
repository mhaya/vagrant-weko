default[:rpmforge][:yumplugin] = "yum-plugin-priorities"
default[:rpmforge][:repofile] = "/etc/yum.repos.d/CentOS-Base.repo"

case node[:platform]
when 'centos'
  if node["platform_version"].to_i == 6
    
default[:rpmforge][:repofile_tmpl] = "CentOS-Base.repo.erb"
default[:rpmforge][:rpm_url] = "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm"
default[:rpmforge][:rpm] ="rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm"
default[:rpmforge][:rpm_checksum] = "1f98252908e397f70a216964ed836e93ba4e80550eac343586895a993a41afb7"

  elsif node["platform_version"].to_i == 7
    default[:rpmforge][:repofile_tmpl] = "CentOS-Base.repo.7.erb"
    default[:rpmforge][:rpm_url] = "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm"
default[:rpmforge][:rpm] ="rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm"
default[:rpmforge][:rpm_checksum] = "2a4f6fbefad4e7c562730fb473099985910c4749792f60ec734e1532d4397a59"
end
end
