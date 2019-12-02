platform :ios, '10.0'


inhibit_all_warnings!
use_frameworks!


def common_pods
  
  pod 'Utils', '0.0.11', :source => 'https://github.com/iznv/Podspecs.git'
  
end


target 'Steam' do

  common_pods

  pod 'FlagKit'
  pod 'R.swift'
  pod 'ScrollableGraphView'
  pod 'SnapKit'
  pod 'StatefulViewController'
  pod 'TableKit'
  pod 'WEBBCode'
  
  target 'SteamTests' do
    inherit! :search_paths
  end

end


target 'ApiKit' do

  common_pods

end


target 'DataKit' do

  common_pods

end


target 'SteamKit' do

  common_pods

end
