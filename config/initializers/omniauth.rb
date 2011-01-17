Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, 'BVvHnRLK20dZGZxO7Gg9A', 'XmY13mlAVG8QeMQvSZkRzVvrUTVUyMUw5rNQD9bHFI'  
  provider :facebook, '157661947590569', 'd9a7ab04b8fe89f523aa31d39749539f'
end  



