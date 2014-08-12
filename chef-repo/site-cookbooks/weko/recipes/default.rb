subversion "weko" do
  repository "http://forge.at.nii.ac.jp/svn/nc/repository/trunk"
  revision "HEAD"
  destination "/usr/local/repository"
  action :checkout
end

