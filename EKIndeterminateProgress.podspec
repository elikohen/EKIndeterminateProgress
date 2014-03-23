Pod::Spec.new do |s|

  s.name         = "EKIndeterminateProgress"
  s.version      = "0.0.1"
  s.summary      = "iOS custom Indeterminate progress view that allows random multiple progress images."

  s.description  = <<-DESC
                  An UIView that animates random progressImages translating and/or rotating it over the background.
                   DESC

  s.homepage     = "https://github.com/elikohen/EKIndeterminateProgress"

  s.license      = 'MIT'

  s.author             = { "Eli Kohen" => "elikohen@gmail.com" }
  
  s.platform     = :ios, '6.0'

  s.source       = { :git => "https://github.com/elikohen/EKIndeterminateProgress.git", :tag => "0.0.1" }

  s.source_files  = 'EKIndeterminateProgress/*.{h,m}'
  s.exclude_files = 'IndeterminateProgressSample'

  s.public_header_files = 'EKIndeterminateProgress/EKIndeterminateProgressView.h'

  s.requires_arc = true
  s.frameworks = 'QuartzCore'

end
