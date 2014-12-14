#default[:oaicatmuseum][:file] = "oaicatmuseum_1.1.war"
default[:oaicatmuseum][:file] = "oaicatmuseum.war"
default[:oaicatmuseum][:webapps_dir] = "#{node[:tomcat][:webapps_dir]}/oaicatmuseum"
default[:oaicatmuseum][:file_url] = "http://www.oclc.org/content/dam/research/activities/oaicatmuseum/oaicatmuseum_1.1.war"
default[:oaicatmuseum][:file_checksum] = "b2034e117585d79aee35a2c6edcc07c66074b18e9b30edb8fd5df26e4dec15d2"
#default[:oaicatmuseum][:file2] = "oaicatdb.sql"
#default[:oaicatmuseum][:file2_url] = "http://www.oclc.org/content/dam/research/activities/oaicatmuseum/oaicatdb.sql"
#default[:oaicatmuseum][:file2_checksum] = "4da3b9620495d78fab5c8f1c005ad127492f0c2a4d6712c210e25aa395949fd1"
default[:oaicatmuseum][:file2] = "oaicatdb2.sql"



