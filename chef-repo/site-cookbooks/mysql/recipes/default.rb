package "mysql" do
  package_name "mysql-server"
  action :install
end

service "mysql" do
  service_name "mysql"
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
