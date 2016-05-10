case node[:platform]
when "centos"
  if node["platform_version"].to_i == 6
    bash 'localedef' do 
      code 'localedef -f UTF-8 -i ja_JP ja_JP.UTF-8'
    end
  elsif node["platform_version"].to_i == 7
    bash 'localectl' do
      code 'localectl set-locale LANG=ja_JP.UTF-8'
    end
  end
end

