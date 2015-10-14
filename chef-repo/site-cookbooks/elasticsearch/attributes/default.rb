default[:elasticsearch][:pkgs] = %w[java-1.7.0-openjdk unzip]

# elastic search
default[:elasticsearch][:filename] = "elasticsearch-1.7.1.tar.gz"
default[:elasticsearch][:remote_uri] = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz"
default[:elasticsearch][:checksum] = "86a0c20eea6ef55b14345bff5adf896e6332437b19180c4582a346394abde019"
default[:elasticsearch][:install_dir] = "/usr/local"

# service wrapper
default[:elasticsearch_srv][:filename] = "elasticsearch-servicewrapper.zip"
default[:elasticsearch_srv][:remote_uri] = "https://github.com/elastic/elasticsearch-servicewrapper/archive/master.zip"
default[:elasticsearch_srv][:checksum] = "994d259a9df56cdfc637b29909701a04be49dcb023906dfa859d4ad5cd1380cb"
default[:elasticsearch_srv][:install_dir] = "/usr/local/elasticsearch-1.7.1"
default[:elasticsearch_srv][:service_name] = "elasticsearch"
