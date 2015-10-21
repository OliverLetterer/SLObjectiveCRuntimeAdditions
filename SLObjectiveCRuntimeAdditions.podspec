Pod::Spec.new do |s|
  s.name                  = "SLObjectiveCRuntimeAdditions"
  s.version               = "1.2.0"
  s.summary               = "Objc runtime additions."
  s.homepage              = "https://github.com/OliverLetterer/SLObjectiveCRuntimeAdditions"
  s.license               = 'MIT'
  s.author                = { "Oliver Letterer" => "oliver.letterer@gmail.com" }
  s.source                = { :git => "https://github.com/OliverLetterer/SLObjectiveCRuntimeAdditions.git", :tag => s.version.to_s }
  s.source_files          = 'SLObjectiveCRuntimeAdditions'
  s.requires_arc          = true
  s.frameworks            = 'Foundation'

  s.platforms = { :ios => '8.0', :osx => '10.10', :tvos => '9.0' }

  s.prefix_header_contents = '#ifndef NS_BLOCK_ASSERTIONS', '#define __assert_unused', '#else', '#define __assert_unused __unused', '#endif'
end
