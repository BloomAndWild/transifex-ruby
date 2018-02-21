module Transifex
  class Resource
    attr_accessor :client, :categories, :i18n_type, :source_language_code, :slug, :name

    def initialize(project_slug, transifex_data)
      @project_slug = project_slug
      @name = transifex_data[:name]
      @categories = transifex_data[:categories]
      @i18n_type = transifex_data[:i18n_type]
      @source_language_code = transifex_data[:source_language_code]
      @slug = transifex_data[:slug]
    end

    def content
      client.get("project/#{@project_slug}/resource/#{@slug}/content/")
    end

    def translation(lang)
      Transifex::Translation.new(@project_slug, @slug, lang).tap do |t|
        t.client = client
      end
    end

    def stats(lang = nil)
      base_url = "project/#{@project_slug}/resource/#{@slug}/stats/"

      if lang
        stats = client.get("#{base_url}#{lang}/")
        Transifex::Stats.new(stats)
      else
        stats = client.get(base_url)
        stats.each_with_object({}) do |(lang, stats), ret|
          ret[lang] = Transifex::Stats.new(stats).tap do |r|
            r.client = client
          end
        end
      end
    end

    def update_content(content)
      client.put(
        "project/#{@project_slug}/resource/#{@slug}/content/",
        {content: content.to_json}.to_json
      )
    end
  end
end
