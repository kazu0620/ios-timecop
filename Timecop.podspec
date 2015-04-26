Pod::Spec.new do |s|
  s.name         = "Timecop"
  s.version      = "0.1"
  s.summary      = "A Library providing 'time travel', 'time freezing', and 'time acceleration' capabilities, making it simple to test time-dependent code."
  s.homepage     = "https://github.com/kazu0620/ios-timecop"
  s.license      = "MIT"
  s.author       = { "Kazuhiro Sakamoto" => "kazu620@gmail.com" }
  s.source       = { :git => "https://github.com/kazu0620/ios-timecop.git", :tag => "0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true
end
