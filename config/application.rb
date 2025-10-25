require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorkGithub
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :ja
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # field_with_errors によるレイアウト崩れ防止
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      # NokogiriというHTMLパサーを使用して文字列のHTMLタグをDOM（構造）として解析する
      html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
      # Nokogiriで解析したHTML要素に対して、is-invalid クラスを追加する
      html.children.add_class('is-invalid')
      # html.to_htmlで再びHTML形式に戻す、.html_safeでHTMLとしてそのまま（エスケープを無効化して）出力させる
      html.to_html.html_safe
    end
  end
end
