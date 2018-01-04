Pod::Spec.new do |s|
  s.name         = "WPObjectMapper"
  s.version      = "0.0.7"
  s.summary      = "This is a drop-in category of NSObject that makes it easy to initialize custom objects from JSON or XML."
  s.description  = <<-DESC
                   This was originally sourced from the NSObject-ObjectMap category. Used mostly in PostKit for ingestion of content.
                   DESC

  s.homepage     = "https://github.com/WPMedia/ios-object-mapper"
  s.license      = { :type => 'UA', :file => 'LICENSE' }
  s.author       = "The Washington Post"

  s.ios.deployment_target = '7.0'
  s.watchos.deployment_target = '2.0'

  s.source       = { :git => "git@github.com:WPMedia/ios-object-mapper.git", :tag => s.version.to_s }

  s.source_files = 'WPObjectMapper'
end
