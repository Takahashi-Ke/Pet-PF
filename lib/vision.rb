require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def image_analysis(post_image)
      
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"
      
      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open(post_image).read)
      
      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              "type": "SAFE_SEARCH_DETECTION"
            }
          ]
        }]
      }.to_json
      # Google Cloud Vision APIに画像を送信してリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      result = JSON.parse(response.body)['responses'][0]['safeSearchAnnotation'].to_h
      
      # 解析結果が「LIKELY」又は「VERY_LIKELY」を含む場合はfalse、それ以外はtrueを返す
      if result.values.include?("LIKELY") || result.values.include?("VERY_LIKELY")
        return false
      else
        return true
      end
      
    end
  end
end