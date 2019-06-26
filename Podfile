platform :ios, '11.0'
use_frameworks!

def defaultPods
    pod 'AlamofireImage', '~> 3.5'
end

target 'CommentViewer' do
    defaultPods
    
    target 'CommentViewerTests' do
        inherit! :search_paths
        defaultPods
    end
    
    target 'CommentViewerUITests' do
        inherit! :search_paths
        defaultPods
    end
    
end
