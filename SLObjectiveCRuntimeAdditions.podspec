Pod::Spec.new do |s|
  s.name         = "SLObjectiveCRuntimeAdditions"
  s.version      = "1.0.1"
  s.summary      = "Objc runtime additions."
  s.homepage     = "https://github.com/OliverLetterer/SLObjectiveCRuntimeAdditions"
  s.license      = 'MIT'
  s.author       = { "Oliver Letterer" => "oliver.letterer@gmail.com" }
  s.source       = { :git => "https://github.com/OliverLetterer/SLObjectiveCRuntimeAdditions.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'

  s.source_files  = 'SLObjectiveCRuntimeAdditions'

  s.requires_arc = true
  s.frameworks = 'Foundation'
end
